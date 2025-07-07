#!/bin/sh

# only performs unlink. Ensures that physical file won't be inpacted if
# present.
rm -f "$HOME"/.ripgreprc 2>/dev/null
if [ -f "$HOME"/.ripgreprc.bak ]; then
  mv "$HOME"/.ripgreprc.bak "$HOME"/.ripgreprc
  echo "Your default .ripgreprc have been restored"
fi
