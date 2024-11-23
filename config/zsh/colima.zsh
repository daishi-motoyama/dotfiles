#!/usr/bin/env zsh

#colimaが起動していない場合は起動
if [[ $(colima status 2>&1) == *"is not running"* ]]; then
  echo "Colima is not running. Starting Colima...";
  colima start;
fi

# ソケットをcolimaに設定
# https://github.com/jesseduffield/lazydocker/issues/311#issuecomment-1044836783
export DOCKER_HOST=$(docker context inspect | jq '.[] | select(.Name == "'$(docker context show)'") | .Endpoints.docker.Host' -r)
