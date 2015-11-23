echo "fish: ----LOCAL----"

# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme bobthefish

# All built-in plugins can be found at ~/.oh-my-fish/plugins/
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Enable plugins by adding their name separated by a space to the line below.
set fish_plugins theme

set -g __fish_vi_mode 1
set -U fish_key_bindings fish_user_key_bindings


# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

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

alias "c=xclip"
alias "v=xclip -o"

set -g theme_display_ruby no
