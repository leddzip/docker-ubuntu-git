set -e

#===============================
# This scripts assert that git is installed
# correctly
#

IMAGE_NAME=$1


git_version=$(docker run --rm "$IMAGE_NAME" git --version)

git_version_text="$(echo "$git_version" | cut -d " " -f 1-2)"
git_version_number="$(echo "$git_version" | cut -d " " -f 3)"

if [[ "$git_version_text" == "git version" ]]
then
  echo "git version text is correct"
  echo "expected 'git version', got '$git_version_text'"
else
  >&2 echo "git version text is NOT correct"
  >&2 echo "expected 'git version', got '$git_version_text'"
  exit 1
fi

if [[ "$git_version_number" =~ ^[0-9]*\.[0-9]*\.[0-9]*$ ]]
then
  echo "git version number has expected format"
  echo "expected 'x.yy.zzz', got '$git_version_number'"
else
  >&2 echo "git version text has NOT the expected format"
  >&2 echo "expected 'x.yy.zzz', got '$git_version_number'"
  exit 2
fi