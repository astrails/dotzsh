function g()
{
  local dir=$(\ls ~/.g/ | fzf --select-1 -q "$*")

  if [ -n "$dir" ]; then
    dir=$(cd ~/.g/"$dir";pwd -P)
    echo changing to $dir
    echo

    cd $dir
    _ruby_setup
  fi
}

# remember last CD directory
function mm() { pwd > ~/.last_dir }
function chpwd { mm }

# change to the last directory
function gg() { cd "`cat ~/.last_dir`" }

# change to the last directory on new shell
gg
