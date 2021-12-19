# Defined in /tmp/fish.DbAqVw/fish_user_key_bindings.fish @ line 2
function bind_bang
	switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end
