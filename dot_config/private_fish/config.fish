# Ensure fundle is installed
# if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

# # fundle plugins
# fundle plugin 'danhper/fish-ssh-agent'
# fundle plugin 'jethrokuan/z'
# fundle plugin 'laughedelic/pisces'
# fundle plugin 'edc/bass'
# fundle plugin 'oh-my-fish/plugin-thefuck'

# fundle init

# Start powerline
powerline-daemon -q
set fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
powerline-setup

# env vars
# set -x CUDA_HOME /opt/cuda
# set -x EDITOR /usr/bin/nvim
# set -x VIRTUAL_ENV_DISABLE_PROMPT true
# set -x GOPATH /home/travis/go
# set -x _JAVA_AWT_WM_NONREPARENTING 1

# set LD_LIBRARY
# needed for cudnn
# set -Uxa LD_LIBRARY_PATH /opt/cudnn7-cuda10.2/lib/

# set PATH
# set -gx PATH $GOPATH/bin $PATH
# set -gx PATH ~/.gem/ruby/2.7.0/bin $PATH

# start thefuck
# thefuck --alias | source
