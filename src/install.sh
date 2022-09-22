#!/bin/bash
########################################################################################################################
# - Check for required tools
# - Install if not available
# - Print Version
######################################################################################################################
SCRIPT_DIRECTORY=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_DIRECTORY/functions.sh"
get_opts "$@"

function install_terraform ()
{
    if ! command -v terraform &> /dev/null || [ "$OVERRIDE" == "true" ];  then
        echo "terraform could not be found, installing."
        unzip -u $SCRIPT_DIRECTORY/install/terraform_1.3.0_linux_amd64.zip -d /tmp/
        dest="${INSTALL_PATH:-/usr/local/bin}/"
        echo "Installing /tmp/tflint to ${dest}..."
        if [[ -w "$dest" ]]; then SUDO=""; else
            # current user does not have write access to install directory
            SUDO="sudo";
        fi
        $SUDO mkdir -p "$dest"
        $SUDO install -c -v /tmp/terraform "$dest"
        retVal=$?
        if [ $retVal -ne 0 ]; then
            echo "Failed to install terraform"
            exit $retVal
        fi
        rm -f /tmp/tflint  
    fi
    terraform --version &> /dev/null
    if [[ $? -ne 0 ]]; then
     echo -e "  * ${ERR}Error: terraform not found!${NC}"
     exit 1
 else
     echo -e "  * ${OK}Terraform Version:${NC} `terraform --version -json | jq -r '.terraform_version'`"
 fi
}

function install_tflint ()
{
    if ! command -v tflint &> /dev/null || [ "$OVERRIDE" == "true" ]; then
        echo "tflint could not be found, installing."
        unzip -u $SCRIPT_DIRECTORY/install/tflint_linux_amd64.zip -d /tmp/
        dest="${INSTALL_PATH:-/usr/local/bin}/"
        echo "Installing /tmp/tflint to ${dest}..."
        if [[ -w "$dest" ]]; then SUDO=""; else
            # current user does not have write access to install directory
            SUDO="sudo";
        fi
        $SUDO mkdir -p "$dest"
        $SUDO install -c -v /tmp/tflint "$dest"
        retVal=$?
        if [ $retVal -ne 0 ]; then
            echo "Failed to install tflint"
            exit $retVal
        fi
        rm -f /tmp/tflint
    fi
    tflint --version &> /dev/null
    if [[ $? -ne 0 ]]; then
    echo -e "  * ${ERR}Error: tflint not found!${NC}"
    exit 1
else
    echo -e "  * ${OK}Tflint Version:${NC} `tflint --version`"
fi
}

install_terraform
install_tflint
