function g()
{
  if [ -z "$1" ]; then
    /bin/ls ~/.g/ | cat
    read x
    g $x
  else
    local d=`/bin/ls ~/.g/ | grep "^$1" | head -n1`
    if [ -z "$d" ]; then
      d=`/bin/ls ~/.g/ | grep "$1" | head -n1`
    fi
    if [ -z "$d" ]; then
      echo "Can't find $1"
      return
    fi

    d=$(cd ~/.g/"$d";pwd -P)
    echo changing to $d
    echo
    cd $d
  fi
}

alias powlog="tail -f ~/Library/Logs/Pow/*.log ~/Library/Logs/Pow/*/*.log"
