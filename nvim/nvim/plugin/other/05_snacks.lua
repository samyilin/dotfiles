Config.now_if_args(function()
  vim.pack.add({ { src = 'https://github.com/folke/snacks.nvim.git' } })
  require('snacks').setup({
    -- Technically only image needs to be enabed, enable here for sanity check
    lazygit = { enabled = true },
    image = {
      enabled = true,
      -- Display size in terminal cells (defaults 80 X 40).
      doc = { max_width = 100, max_height = 40 },
      -- s=2 keeps text sharp without huge GPU payloads.
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
            's',
            '2',
            '-w',
            '1200',
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
end)
