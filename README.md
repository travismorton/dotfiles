# Dotfiles
## Install
```
curl -sfL https://git.io/chezmoi | sh
chezmoi init https://github.com/username/dotfiles.git
chezmoi apply
```
## Themes
Currently, the install will check if the env var `$DARK==true`, in which case it will use the dark variant. Currently using `base16-ia-dark` and `base16-ia-light` (default). To change from dark to light, simply set or unset the `DARK` env var and rerun `chezmoi apply`
