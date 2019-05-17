#!/bin/bash

function usage_exit() {
    echo "
    Usage:
    ./jetbrains.sh <IDE_TYPE>-<VERSION>

    Options:
        IDE_TYPE    name of jetbrains' IDE  ex.) pycharm, clion, idea
        VERSION     version string          ex.) 2017.2, 2017.2.3

    Example to install clion ver.1.2 and pycharm ver.4.5

    1) ./install.sh clion-1.2
       ./install.sh pycharm-4.5

    2) ./install.sh clion-1.2 pycharm-4.5
    " | sed 's/\s\s\s\s//'

    exit
}

function pycharm() {
    NAME=${FUNCNAME[0]}
    URL="https://download.jetbrains.com/python/pycharm-professional-${VER}.tar.gz"
}
function pycharm_ce() {
    NAME=${FUNCNAME[0]}
    URL="https://download.jetbrains.com/python/pycharm-community-${VER}.tar.gz"
}

function clion() {
    NAME=${FUNCNAME[0]}
    URL="https://download.jetbrains.com/cpp/CLion-${VER}.tar.gz"
}

function idea() {
    NAME=${FUNCNAME[0]}
    URL="https://download.jetbrains.com/idea/ideaIC-${VER}.tar.gz"
}


function run_install() {
    if ! type curl 1>/dev/null 2>&1; then
        echo 'curl not found.'
        exit 0
    fi
    
    INSTALL_DST=${HOME}/.local/${NAME}
    if [ -d ${INSTALL_DST} ]; then
        rm -rf ${INSTALL_DST}
    fi
    mkdir -pv ${INSTALL_DST}

    echo 'download and install'
    curl -fSL# ${URL} | tar -xzC ${INSTALL_DST} --strip-components=1
    
    # create symbolic link
    if [ ! -d "${HOME}/.local/bin" ]; then
        mkdir -pv ${HOME}/.local/bin
    fi
    
    RUN="${INSTALL_DST}/bin/${NAME}.sh"
    ln -fnsv ${RUN} ${HOME}/.local/bin/${NAME}
    ${RUN}
}


if [[ $# == 0 ]]; then
    echo "IDE is not specified"
    usage_exit
fi

for OPT in $@
do
    # parse IDE string
    opt_arr=($(echo $OPT | tr '-' ' '))
    IDE=${opt_arr[0]}
    VER=${opt_arr[1]}
    echo "Install ${IDE} ver.${VER}"

    if type ${IDE} 1>/dev/null 2>&1; then
        eval ${IDE}
        run_install
    else
        echo -e "Undefined Jetbrains IDE: ${IDE}"
        usage_exit
    fi
done

