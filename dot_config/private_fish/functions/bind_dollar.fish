# Defined in /tmp/fish.DbAqVw/fish_user_key_bindings.fish @ line 11
function bind_dollar
	switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
