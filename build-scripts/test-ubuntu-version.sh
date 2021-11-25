set -e

#===============================
# This scripts assert that the correct ubuntu version is used in
# the docker image passed as first argument.
#

IMAGE_NAME=$1

if [[ -z "${UBUNTU_VERSION}" ]]; then
  exit 1
else
  ubuntu_version=$(docker run --rm "$IMAGE_NAME" cat /etc/os-release | grep "VERSION_ID")

  if [[ "ubuntu_version" == "VERSION_ID=\"${UBUNTU_DOCKER_TAG}\"" ]]
  then
    echo "poetry version is correct"
    echo "expected $UBUNTU_DOCKER_TAG, got $ubuntu_version"
  else
    >&2 echo "poetry version is NOT correct"
    >&2 echo "expected $UBUNTU_DOCKER_TAG, got $ubuntu_version"
    exit 2
  fi
fi