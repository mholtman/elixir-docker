#!/bin/bash

main() {
  COMMAND_RUN_ON_HOST=(docker run --rm)
  append_tty_args_when_connected_to_tty
  append_volume_and_working_dir
  append_versioned_ansible_docker_image

  COMMANDS_RUN_IN_CONTAINER="$*"

  exec "${COMMAND_RUN_ON_HOST[@]}" /bin/ash -c "${COMMANDS_RUN_IN_CONTAINER[@]}"
}

append_tty_args_when_connected_to_tty() {
  [[ -t 0 && -t 1 ]] && COMMMAND_RUN_ON_HOST+=(-it)
}

append_versioned_ansible_docker_image() {
  COMMAND_RUN_ON_HOST+=("${DOCKER_IMAGE_OVERRIDE}")
}

append_volume_and_working_dir() {
  COMMAND_RUN_ON_HOST+=(--net=bridge \
                        --volume $(pwd):/work \
                        --workdir /work)
}

main "$@"
