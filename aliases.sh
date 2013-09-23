function g()
{
  if [ -z "$1" ]; then
    /bin/ls -l ~/.g/ | grep / | cut -d: -f2- | cut -d\  -f2-
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
    local p=`readlink ~/.g/"$d"`
    echo
    echo changing ot $p
    echo
    cd $p
  fi
}
