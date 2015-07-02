alias ddr="docker run -it --rm"
alias ds="docker swarm"
alias dm="docker machine"

function dmu
{
  echo using dockerhost "$@"

  docker-machine env "$@" > ~/.docker/.machine.sh
  source ~/.docker/.machine.sh

  echo $DOCKER_HOST

  export DOCKER_IP=$(docker-machine ip "$@")
}

if [ -e ~/.docker/.machine.sh ]; then
  source ~/.docker/.machine.sh
fi

if [ -e ~/.digitaloceanrc ]; then
  source ~/.digitaloceanrc
fi


DOCKER="`which docker`"
function docker()
{
  if [ -n "$1" ]; then
    local cmd="$1"; shift

    if which "docker-$cmd" > /dev/null; then
      "docker-$cmd" "$@"
    else
      "$DOCKER" "$cmd" "$@"
    fi
  else
    "$DOCKER"
  fi
}
