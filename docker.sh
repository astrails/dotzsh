source ~/.digitaloceanrc

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

source ~/.docker/.machine.sh
