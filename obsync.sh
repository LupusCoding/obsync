#!/bin/bash
# Unix bash skript
__name__="obsync"
__slogan__="Your favorite obsidian git synchronisation tool!"
__author__="Ralph Dittrich <dittrich.ralph@lupuscoding.de>"
__version__='0.1.0'
# SCRIPT OPTS
_opt_verbose=0
_opt_silent=0
# COMMAND OPTS
_cmd_path=""
_cmd_repo=""
_cmd_token=""
_cmd_new=0

########
# Misc #
########
function out() {
    if [[ $_opt_silent -eq 0 ]]; then
        echo "[`date +'%x %H:%M:%S'`] ${1}"
    fi
}

function vout() {
    if [[ $_opt_verbose -eq 1 ]]; then
        out "${1}"
    fi
}

function warn() {
    out "WARN: ${1}"
}

function error() {
    _opt_silent=0
    out "ERR: ${1}"
    exit 1
}

function fatal() {
    wall "ERROR: ${1}"
    error "$1"
}

function prepareUrl() {
    if [[ "${_cmd_repo:0:4}" == "git@" ]]; then
        error "Given url is an SSH url. Please use the https url."
    elif [[ "${_cmd_repo:0:5}" == "https" ]]; then
        _cmd_repo="${_cmd_repo:8}"
    elif [[ "${_cmd_repo:0:4}" == "http" ]]; then
        _cmd_repo="${_cmd_repo:7}"
    fi
}

# Git methods
function git_update() {
    git add --all
    git commit -m "Auto-update from $(hostname)"
}

function git_pull() {
    git fetch
    if [[ $(git status --porcelain | wc -l) -gt 0 ]]; then
        git_update
        vout "Push update to server"
    fi
    git rebase origin/master
}

function git_push() {
    git push origin master
}

function git_create_ignore() {
    vout "Create ignore file"
    echo ".obsidian" > "$(pwd)/.gitignore"
    git add .gitignore
    git commit -m "Initial commit"
}

#########
# Tests #
#########
function fail_is_git_root() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null;) == "true" ]]; then
        fatal "Obsidian Init failed: $(pwd) is already a git repository."
    fi
}

function fail_no_git_root() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null;) != "true" ]]; then
        fatal "Obsidian Init failed: $(pwd) is not an git repository."
    fi
}

function fail_no_obsidian_root() {
    if [[ ! -d "${_cmd_path}/.obsidian/" ]]; then
        fatal "Obsidian Init failed: $(pwd) is not an Obsidian vault."
    fi
}

############
# commands #
############
# show version info
function version() {
    _border='############################################################'
    _space='                                                            '
    echo "${_border:0:60}"
    echo "# ${__name__:0:56}${_space:0:$((56 - ${#__name__}))} #"
    echo "# - ${__slogan__:0:54}${_space:0:$((54 - ${#__slogan__}))} #"
    echo "#${_space:0:58}#"
    echo "# v${__version__:0:55}${_space:0:$((55 - ${#__version__}))} #"
    echo "# ${__author__:0:56}${_space:0:$((56 - ${#__author__}))} #"
    echo "${_border:0:60}"
}

# initialize a new obsidian git repo
function init() {
    if [ "${#_cmd_path}" -eq 0 ]; then
        error "path argument is missing '${_cmd_path}'"
    elif [ "${#_cmd_repo}" -eq 0 ]; then
        error "repo argument is missing '${_cmd_repo}'"
    elif [ "${#_cmd_token}" -eq 0 ]; then
        error "token argument is missing '${_cmd_token}'"
    fi

    _call_dir=$(pwd)
    cd "${_cmd_path}"

    out "Obsidian init $(pwd) started"
    fail_no_obsidian_root
    fail_is_git_root

    git init
    prepareUrl
    vout "Add repository ${_cmd_repo}"
    git remote add origin "https://${_cmd_token}@${_cmd_repo}"
    if [ $_cmd_new -eq 1 ]; then 
        git_create_ignore
    fi
    git_pull
    git_up

    out "Obsidian init $(pwd) finished"
    cd "${_call_dir}"
    exit 0
}

# synchronize an initialized obsidian git repo
function sync() {
    if [[ "${#_cmd_path}" -eq 0 ]]; then
        error "path argument is missing '${_cmd_path}'"
    fi
    _call_dir=$(pwd)
    cd "${_cmd_path}"

    out "Obsidian sync $(pwd) started"
    fail_no_obsidian_root
    fail_no_git_root

    vout "Fetch updates from server"
    git_pull
    git_up
    
    out "Obsidian sync $(pwd) finished"
    cd "${_call_dir}"
    exit 0
}

function usage() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: obsync [OPTIONS] COMMAND [COMMAND OPTIONS]"
        echo ""
        echo "v${__version__}"
        echo ""
        echo "COMMANDS"
        echo "  init                  Initialize an obsidian repository."
        echo "    -n | --new            (optional) Init a new repository instead of an existing one."
        echo "    --path PATH           (required) Path to Obsidian vault folder."
        echo "    --repo URL            (required) Git repository URL."
        echo "    --token TOKEN         (required) Git personal access token."
        echo "  sync                  Synchronize an obsidian repository."
        echo "    --path PATH           (required) Path to Obsidian vault folder."
        echo "  version               Display obsync version."
        echo ""
        echo "OPTIONS"
        echo "  -h | --help           Display this help."
        echo "  -s | --silent         Activate silent mode."
        echo "  -v | --verbose        Activate verbose mode."
    fi
}

###########################
# command line processing #
###########################
_TMP="$@"
# capture options
while [[ $# -gt 0 ]]; do
    case "$1" in
        # COMMAND OPTS
        --path)
            _cmd_path="${2}"; shift ;;
        --repo)
            _cmd_repo="${2}"; shift ;;
        --token)
            _cmd_token="${2}"; shift ;;
        -n | --new)
            _cmd_new=1 ;;

        # SCRIPT OPTIONS
        -v | --verbose)
            _opt_verbose=1 ;;
        -s | --silent)
            _opt_silent=1 ;;
        -h | --help)
            usage
            exit 0
            ;;
    esac
    shift
done
# capture command
eval set -- "$_TMP"
while [[ $# -gt 0 ]]; do
    case "$1" in
        # COMMANDS
        sync)
            sync ;;
        init)
            init ;;
        version)
            version
            exit 0
            ;;
    esac
    shift
done
# error if we don't capture a valid command
echo "ERR: Unknown command"
echo ""
usage
exit 1
