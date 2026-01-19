#            _              
#    _______| |__  _ __ ___ 
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__ 
# (_)___|___/_| |_|_|  \___|
#                           
# -----------------------------------------------------
# ML4W zshrc loader
# -----------------------------------------------------

# DON'T CHANGE THIS FILE

# You can define your custom configuration by adding
# files in ~/.config/zshrc 
# or by creating a folder ~/.config/zshrc/custom
# with copies of files from ~/.config/zshrc 
# -----------------------------------------------------

(cat ~/.cache/wallust/sequences)
for f in ~/.config/zshrc/*; do 
    if [ ! -d $f ] ;then
        c=`echo $f | sed -e "s=.config/zshrc=.config/zshrc/custom="`
        [[ -f $c ]] && source $c || source $f
    fi
done
export PATH=/home/inorishio/.local/bin:/usr/lib/ccache/bin/:/usr/lib/ccache/bin/:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl

eval "$(zoxide init --cmd cd zsh)"

# bun completions
[ -s "/home/inorishio/.bun/_bun" ] && source "/home/inorishio/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export MANPATH=$HOME/tools/ripgrep/doc/man:$MANPATH
export FPATH=$HOME/tools/ripgrep/complete:$FPATH
