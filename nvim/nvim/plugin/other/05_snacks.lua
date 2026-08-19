Config.now_if_args(function()
  vim.pack.add({ { src = 'https://github.com/folke/snacks.nvim.git' } })

  -- Inline doc images may use the full window instead of the stock 80x40
  -- cap. Refreshed on VimResized below; propagated to already-visible
  -- placements by the placement.state wrapper in this file.
  local function doc_caps()
    return math.max(60, vim.o.columns - 8), math.max(20, vim.o.lines - 8)
  end
  local max_width, max_height = doc_caps()

  require('snacks').setup({
    -- Technically only image needs to be enabed, enable here for sanity check
    lazygit = { enabled = true },
    image = {
      enabled = true,
      -- Display size in terminal cells (defaults 80 X 40).
      doc = { max_width = max_width, max_height = max_height },
      -- s=2 keeps text sharp without huge GPU payloads. -w is the
      -- mermaid-cli page width: scale it to the terminal so wide
      -- diagrams render enough pixels to fill the window
      -- (max(800, ...) keeps the mermaid default for small terminals).
      convert = {
        mermaid = function()
          local theme = vim.o.background == 'light' and 'neutral' or 'dark'
          return {
            '-i',
            '{src}',
            '-o',
            '{file}',
            '-b',
            'transparent',
            '-t',
            theme,
            '-s',
            '2',
            '-w',
            tostring(math.max(800, math.floor(vim.o.columns * 8))),
          }
        end,
      },
    },
  })
  -- Neovim 0.12: vim.wait() while draining TermResponse/UI events can
  -- infinite-loop the event-queue(hang/hard freeze). snacks.image
  -- health does exactly that: nvim_ui_send CSI probe + vim.wait(1500).
  -- Replace health with a non-blocking report (no detect/vim.wait).
  do
    local img = require('snacks.image')
    img.health = function()
      local H = Snacks.health
      for _, name in ipairs({ 'kitty', 'wezterm', 'ghostty' }) do
        if vim.fn.executable(name) == 1 then
          H.ok(("'%s' (present)"):format(name))
        end
      end
      if
        vim.fn.executable('magick') == 1
        or vim.fn.executable('convert') == 1
      then
        H.ok('ImageMagick present')
      else
        H.error('`magick` is required to convert images')
      end

      -- Never call terminal.env()/detect() here: env() sync-detects via
      -- vim.wait + CSI, which can infinite-loop the 0.12 event queue.
      local term = package.loaded['snacks.image.terminal']
      local cached = term and rawget(term, '_env')
      if cached and cached.supported then
        H.ok('kitty graphics protocol supported (cached)')
        if cached.placeholders then
          H.ok('unicode placeholders available (inline ok)')
        end
      elseif
        vim.env.SNACKS_GHOSTTY
        or vim.env.TERM_PROGRAM == 'ghostty'
        or vim.env.KITTY_WINDOW_ID
        or vim.env.TERM_PROGRAM == 'kitty'
        or vim.env.WEZTERM_EXECUTABLE
      then
        H.ok('terminal looks image-capable via env (detect skipped)')
      else
        H.warn('could not confirm kitty graphics support (detect skipped)')
      end

      if vim.fn.executable('mmdc') == 1 then
        H.ok('mmdc present (mermaid)')
      else
        H.warn('`mmdc` required for mermaid diagrams')
      end
      if vim.fn.executable('gs') == 1 then
        H.ok('gs present (PDF)')
      else
        H.warn('`gs` required for PDF files')
      end
    end
  end

  -- same class of hang: notifier health uses vim.wait(500).
  -- `:checkhealth snacks` loads every module via meta.get(), so guard
  -- it even though notifier is disabled. Report the real state:
  -- package.loaded can't tell (the require below populates it).
  do
    local ok, notifier = pcall(require, 'snacks.notifier')
    if ok and notifier.health then
      notifier.health = function()
        if Snacks.config.notifier.enabled then
          Snacks.health.ok('notifier enabled')
        else
          Snacks.health.info('notifier disabled')
        end
      end
    end
  end

  vim.keymap.set(
    'n',
    '<Leader>gg',
    function() Snacks.lazygit() end,
    { desc = 'Lazygit' }
  )

  -- PDF page flipping --------------------------------------------------
  -- snacks.image renders one page at a time. The page comes from a
  -- `#page=N` fragment in the src (see snacks/image/convert.lua
  -- M.get_page), but nothing in the plugin flips it, so we do it
  -- ourselves: clean the placement and re-create it with a new fragment.
  -- Applies to PDFs opened directly as image buffers (filetype=image).
  local pdf = { page = {} } -- buf -> { src = string, page = number, total = number? }

  ---@param buf number
  ---@return boolean
  local function is_image_buf(buf)
    return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == 'image'
  end

  ---@param buf number
  ---@return boolean
  local function is_pdf_image(buf)
    return is_image_buf(buf)
      and vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':e'):lower()
        == 'pdf'
  end

  ---@param buf number
  ---@return boolean
  local function is_pdf(buf)
    return vim.api.nvim_buf_is_valid(buf)
      and vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':e'):lower()
        == 'pdf'
  end

  -- Image buffers fill their window ------------------------------------
  -- snacks.image.util.fit() only *down*scales: an image whose natural
  -- size fits the window is shown at natural size, leaving empty space
  -- around it. Force a contain-fit upscale for any image buffer opened
  -- directly (PDF, PNG, ...) so it fills the window (aspect preserved).
  -- Tiny rasters (icons, thumbnails: natural size below MIN_FILL cells in
  -- both dimensions) are left alone - upscaling them would just smear
  -- pixels. PDFs always clear the floor (vector-rendered at high dpi).
  -- Inline doc images are NOT upscaled (that would bury the text), but
  -- their size caps are refreshed here so resizes take effect.
  local MIN_FILL = 16
  local state = Snacks.image.placement.state
  Snacks.image.placement.state = function(self)
    if self.opts.inline then
      local doc = Snacks.image.config and Snacks.image.config.doc
      if doc then
        self.opts.max_width = doc.max_width
        self.opts.max_height = doc.max_height
      end
    end
    local st = state(self)
    if
      st.loc
      and is_image_buf(self.buf)
      and not self.opts.inline
      and math.max(st.loc.width, st.loc.height) >= MIN_FILL
    then
      local width, height = vim.o.columns, vim.o.lines
      for _, win in ipairs(self:wins()) do
        width = math.min(width, vim.api.nvim_win_get_width(win))
        height = math.min(height, vim.api.nvim_win_get_height(win))
      end
      local scale = math.min(width / st.loc.width, height / st.loc.height)
      if scale > 1 then
        st.loc.width = math.max(1, math.floor(st.loc.width * scale))
        st.loc.height = math.max(1, math.floor(st.loc.height * scale))
      end
    end
    return st
  end

  local function pdf_src(buf)
    if not is_pdf_image(buf) then return nil end
    return vim.api.nvim_buf_get_name(buf)
  end

  -- gs is already required for snacks' PDF rendering, and returns the
  -- page count ~100x faster than `magick identify` on the whole doc.
  local function pdf_total(path)
    local esc = path:gsub('[()\\]', function(c) return '\\' .. c end)
    local out = vim.fn.system({
      'gs',
      '-q',
      '-dNOSAFER',
      '-dNODISPLAY',
      '-c',
      ('(%s) (r) file runpdfbegin pdfpagecount = quit'):format(esc),
    })
    return tonumber(out:match('%d+')) -- nil when gs is unavailable (no clamping)
  end

  local function pdf_flip(delta)
    local buf = vim.api.nvim_get_current_buf()
    local src = pdf_src(buf)
    if not src then
      vim.notify(
        'Not a PDF image buffer',
        vim.log.levels.WARN,
        { title = 'PDF page' }
      )
      return
    end
    local st = pdf.page[buf]
    if not st or st.src ~= src then
      st = { src = src, page = 1, total = pdf_total(src) }
      pdf.page[buf] = st
    end
    local page = st.page + delta
    if page < 1 then
      page = 1
    elseif st.total and page > st.total then
      page = st.total
    end
    if page == st.page then
      return -- already at the first/last page
    end
    st.page = page
    -- buf.attach()'s supports_file() chokes on the '#page=' fragment
    -- (fnamemodify ':e' yields "pdf#page=2"), so drive the placement
    -- directly, exactly like the doc/inline renderers do.
    Snacks.image.placement.clean(buf)
    Snacks.image.placement.new(buf, src .. '#page=' .. page, {
      conceal = true,
      auto_resize = true,
    })
    vim.notify(
      ('%s - page %d/%s'):format(
        vim.fn.fnamemodify(src, ':t'),
        page,
        st.total or '?'
      ),
      vim.log.levels.INFO,
      { title = 'PDF', id = 'snacks.pdf.page' } -- same id replaces the previous counter
    )
  end

  -- page state is per buffer; reset it on (re)load or buffer removal
  vim.api.nvim_create_autocmd('BufReadCmd', {
    pattern = '*.pdf',
    callback = function(e) pdf.page[e.buf] = nil end,
  })
  vim.api.nvim_create_autocmd({ 'BufWipeout', 'BufDelete' }, {
    callback = function(e) pdf.page[e.buf] = nil end,
  })

  -- Fullscreen tab: if a PDF would land in a split layout, give it its
  -- own fullscreen tab so it gets the whole screen. `nvim file.pdf` from
  -- the shell already opens in a single fullscreen window, so this is a
  -- no-op there.
  vim.api.nvim_create_autocmd('BufWinEnter', {
    pattern = '*.pdf',
    callback = function(e)
      if not is_pdf(e.buf) then return end
      if #vim.api.nvim_tabpage_list_wins(0) == 1 then
        return -- already fullscreen
      end
      local win = vim.api.nvim_get_current_win()
      vim.schedule(function()
        if not vim.api.nvim_buf_is_valid(e.buf) then return end
        vim.cmd('tab sbuffer ' .. e.buf) -- new fullscreen tab
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, false) -- drop the original split
        end
      end)
    end,
  })

  -- keep inline doc caps in sync with the terminal size; visible
  -- placements pick the new values up via the state wrapper above
  vim.api.nvim_create_autocmd('VimResized', {
    callback = function()
      local doc = Snacks.image.config and Snacks.image.config.doc
      if doc then
        doc.max_width, doc.max_height = doc_caps()
      end
    end,
  })

  -- jumplist-style shortcuts: ]p / [p = next / previous page
  vim.keymap.set(
    'n',
    ']p',
    function() pdf_flip(1) end,
    { desc = 'PDF next page' }
  )
  vim.keymap.set(
    'n',
    '[p',
    function() pdf_flip(-1) end,
    { desc = 'PDF previous page' }
  )
end)
