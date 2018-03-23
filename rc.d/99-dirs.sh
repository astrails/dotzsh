function g()
{
  local dir=$(\ls ~/.g/ | fzf -1 -0 -q "$*")

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
function gg() {
  if [ -e ~/.last_dir  ]; then
    cd "`cat ~/.last_dir`"
  fi
}

# change to the last directory on new shell
gg
