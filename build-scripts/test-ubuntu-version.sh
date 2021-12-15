set -ex

#===============================
# This scripts assert that the correct ubuntu version is used in
# the docker image passed as first argument.
#

IMAGE_NAME=$1

if [[ -z "${UBUNTU_DOCKER_TAG}" ]]; then
  exit 1
else
  echo "${UBUNTU_DOCKER_TAG}"
  ubuntu_version=$(docker run --rm "$IMAGE_NAME" cat /etc/os-release | grep "VERSION_ID")

  if [[ "$ubuntu_version" == "VERSION_ID=\"${UBUNTU_DOCKER_TAG}\"" ]]
  then
    echo "ubuntu version is correct"
    echo "expected $UBUNTU_DOCKER_TAG, got $ubuntu_version"
  else
    >&2 echo "ubuntu version is NOT correct"
    >&2 echo "expected $UBUNTU_DOCKER_TAG, got $ubuntu_version"
    exit 2
  fi
fi