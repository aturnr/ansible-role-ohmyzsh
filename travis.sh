#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

# VARIABLES

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

github_token="${GITHUB_TOKEN}"
github_repo="${TRAVIS_REPO_SLUG}"
build_number="${TRAVIS_BUILD_NUMBER}"

# FUNCTIONS

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [OPTIONS]

Travis wrapper script for managing more complicated logic outside of travis.yml configuration file.

Available options:
-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-r, --release   Perform a release

EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  flag_release="false"
  param=''

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -r | --release) flag_release="true" ;;
#    -p | --param) # example named parameter
#      param="${2-}"
#      shift
#      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  # check required params and arguments
#  [[ -z "${param-}" ]] && die "Missing required parameter: param"
#  [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  return 0
}

release() {
  # Setup git configuration
  msg "  - Setting git configuration..."
  git config --global user.email "builds@travis-ci.com"
  git config --global user.name "Travis CI"

  # Get version from package.yml
  msg "  - Finding version for release tag..."
  release_tag="$(awk '/version:/ {print $NF}' package.yml)"
  msg "  - Version found: ${release_tag}"

  # Check version number is unique
  msg "  - Checking version number is unique..."
  if git tag -l | grep -w "${release_tag}"; then
      echo ""
      echo "ERROR: Release version already exists, please update the semantic version in package.yml"
      exit 1
  fi
  msg "  - Version number is unique"

  # Tag release for repository
  msg "  - Tagging release for repository..."
  git remote add origin-travis "https://${github_token}@github.com/${github_repo}.git"
  git tag "${release_tag}" -a -m "Tag from TravisCI for build ${build_number}!"
  git push -q --tags --set-upstream origin-travis
  msg "  - Tagged with tag: ${release_tag}"
}

# MAIN

parse_params "$@"
setup_colors

# script logic here

msg "${RED}Read parameters:${NOFORMAT}"
msg "  - release: ${flag_release}"
msg "  - arguments: ${args[*]-}"

if [ "${flag_release}" == "true" ]; then
  msg "${GREEN}Release:${NOFORMAT}"
  release
fi
