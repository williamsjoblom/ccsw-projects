#!/bin/bash
# Library of functions to be used across scripts
read_os()
{
    os_release=$(cat /etc/os-release | grep "^ID\=" | cut -d'=' -f 2 | xargs)
    os_version=$(cat /etc/os-release | grep "^VERSION_ID\=" | cut -d'=' -f 2 | xargs)
}

function is_scheduler() {
    jetpack config slurm.role | grep -q 'scheduler'
}

function is_login() {
    jetpack config slurm.role | grep -q 'login'
}

function is_compute() {
    jetpack config slurm.role | grep -q 'execute'
}

function install_yq() {
    # Install yq
    if ! command -v yq &> /dev/null; then
        wget -q "https://github.com/mikefarah/yq/releases/download/v4.44.2/yq_linux_amd64" -O /usr/bin/yq
        chmod 0755 /usr/bin/yq
    fi
}

function is_monitoring_enabled() {
    enabled_monitoring=$($JETPACK config monitoring.enabled | tr '[:upper:]' '[:lower:]')
    if [[ $enabled_monitoring == "true" ]]; then
        return 1
    else
        return 0
    fi
}
