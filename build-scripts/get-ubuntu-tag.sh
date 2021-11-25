set -e

#===============================
# This scripts is use to get the ubuntu tag.
#

if [[ -z "${UBUNTU_DOCKER_TAG}" ]]; then
  exit 1
else
  echo "$UBUNTU_DOCKER_TAG"
fi
