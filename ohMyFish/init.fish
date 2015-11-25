# SYNOPSIS
#   Initialize Oh My Fish.
#
# OVERVIEW
#   + Source $OMF_CONFIG/before.init.fish
#
#   + Autoload Oh My Fish packages, themes and config path
#   + For each <pkg> inside {$OMF_PATH,$OMF_CONFIG}
#     + Autoload <pkg> directory
#     + Source <pkg>.fish
#     + Emit init_<pkg> event
#
#   + Autoload {$OMF_PATH,$OMF_CONFIG}/functions
#   + Source $OMF_CONFIG/init.fish
#
# ENV
#   OSTYPE        Operating system.
#   ORIGINAL_PATH Original $PATH preseved across Oh My Fish reloads.
#   OMF_PATH      ~/.local/share/omf by default.
#   OMF_IGNORE    List of packages to ignore.
#   OMF_CONFIG    ~/.config/omf by default.
#   OMF_VERSION   Oh My Fish! version

# Save PATH before oh my fish for reseting the PATH when we reload OMF.
if set -q ORIGINAL_PATH
  set PATH $ORIGINAL_PATH
else
  set -gx ORIGINAL_PATH $PATH
end

# Set OMF_CONFIG if not set.
if not set -q OMF_CONFIG
  set -q XDG_CONFIG_HOME; or set -l XDG_CONFIG_HOME "$HOME/.config"
  set -gx OMF_CONFIG "$XDG_CONFIG_HOME/omf"
end

# Source custom before.init.fish file
source $OMF_CONFIG/before.init.fish ^/dev/null

# Save the head of function path and autoload core functions
set -l user_function_path $fish_function_path[1]
set fish_function_path[1] $OMF_PATH/lib


# Autoload util functions
autoload $OMF_PATH/lib $OMF_PATH/lib/git

for path in {$OMF_PATH,$OMF_CONFIG}/pkg/*
  set -l name (basename $path)

  contains -- $name $OMF_IGNORE; and continue
  require $name
end

# Autoload theme
autoload {$OMF_PATH,$OMF_CONFIG}/themes/(cat $OMF_CONFIG/theme)

# Autoload custom functions
autoload $OMF_CONFIG/functions
autoload $user_function_path

# Source custom init.fish file
source $OMF_CONFIG/init.fish ^/dev/null

set -g OMF_VERSION "1.0.0"

####################################################################
####################################################################
# CUSTOM SCRIPTS

# ----------------------------------------------------------
# DECLARATION HASH 202020
# The fish_mode_prompt function is prepended to the prompt
function fish_mode_prompt --description "Displays the current mode"
  # Do nothing if not in vi mode
  if set -q __fish_vi_mode
    switch $fish_bind_mode
      case default
        # set_color --background 6E6E6E FFFFFF
        set_color --background 000000 normal
        echo '[C]'
      case insert
        set_color --background normal normal
        echo '[I]'
      case replace-one
        set_color --bold red FFFFFF
        echo '[R] '
      case visual
        set_color --bold --background D33682 FFFFFF
        echo '[V]'
    end
    set_color normal
    echo -n ' '
  end
end

# DECLARATION HASH 202020
set -g __fish_vi_mode 1
# ----------------------------------------------------------


# ----------------------------------------------------------
# DECLARATION #HASH 292929
function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert -m default jk backward-char force-repaint
end

# DECLARATION HASH 292929
set -U fish_key_bindings fish_user_key_bindings
# ----------------------------------------------------------



# FUNCTIONS BLOCK
# **********************************************************
function ll
    ls --human-readable -l
end

function myman
    less ~/.myman.txt
end

# Хоткеи для навигации
function ..
    cd ..
end

function ...
    cd ../..
end

function ....
    cd ../../..
end

function .....
    cd ../../../..
end

function ......
    cd ../../../../..
end

# Создать директорию и перейти в неё же. С параметром -p
function mkdircd -d "Create a directory and set CWD"
        command mkdir -p $argv
        if test $status = 0
                switch $argv[(count $argv)]
                        case '-*'
                        case '*'
                                cd $argv[(count $argv)]
                                return
                end
        end
end

# ALIASES BLOCK
# **********************************************************
alias "c=xclip"
alias "v=xclip -o"

