#!/usr/bin/env bash
# source:
#   https://raw.githubusercontent.com/twitter/commons/master/build-support/python/libvirtualenv.sh
function setup_virtualenv() {
  script="$1"; shift        # 'rbt'
  requirements="$1"; shift  # 'RBTools==0.5.5'
  pip_install_opts="$@"     # '--allow-external RBTools --allow-unverified RBTools'
  fingerprint=$(echo $script $requirements | openssl md5 | cut -d' ' -f2)

  HERE=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)
  VENV_DIR="$HERE/../${script}.venv"
  BOOTSTRAPPED_FILE="${VENV_DIR}/BOOTSTRAPPED.${fingerprint}"
  if ! [ -f ${BOOTSTRAPPED_FILE} ]; then
    echo "Bootstrapping ${script} with requirements ${requirements}"
    rm -fr "${VENV_DIR}"
    "$HERE/../virtualenv" "${VENV_DIR}"
    source "${VENV_DIR}/bin/activate"
    pip install ${pip_install_opts} "${requirements}"
    touch "${BOOTSTRAPPED_FILE}"
  else
    source "${VENV_DIR}/bin/activate"
  fi
}
