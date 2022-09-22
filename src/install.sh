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
    echo "- Terraform checks:"
    if ! command -v terraform &> /dev/null || [ "$OVERRIDE" == "true" ];  then
        echo -e "  * ${INF}Terraform${NC}: terraform could not be found, installing."
        unzip -u $SCRIPT_DIRECTORY/install/terraform_1.3.0_linux_amd64.zip -d /tmp/ &> /dev/null
        dest="${INSTALL_PATH:-/usr/local/bin}/"
        echo -e "  * ${INF}Terraform${NC}: Installing terraform to ${OK}${dest}${NC}"
        if [[ -w "$dest" ]]; then SUDO=""; else
            # current user does not have write access to install directory
            SUDO="sudo";
        fi
        $SUDO mkdir -p "$dest"
        $SUDO install -c -v /tmp/terraform "$dest" &> /dev/null
        retVal=$?
        if [ $retVal -ne 0 ]; then
            echo "Failed to install terraform"
            exit $retVal
        fi
        rm -f /tmp/tflint  
    fi
    terraform --version &> /dev/null
    if [[ $? -ne 0 ]]; then
     echo -e "  * ${ERR}Terraform  not found:${OK} terraform not found or not in path!${NC}"
     exit 1
 else
     echo -e "  * ${OK}Terraform:${NC} `which terraform` - `terraform --version -json | jq -r '.terraform_version'`"
 fi
}

function install_tflint ()
{
  echo "- TFlint checks:"
    if ! command -v tflint &> /dev/null || [ "$OVERRIDE" == "true" ]; then
        echo -e "  * ${INF}TFlint:${NC} tflint could not be found, installing."
        unzip -u $SCRIPT_DIRECTORY/install/tflint_linux_amd64.zip -d /tmp/ &> /dev/null
        dest="${INSTALL_PATH:-/usr/local/bin}/"
        echo -e "  * ${INF}TFlint${NC}: Installing tflint to ${OK}${dest}${NC}"
        if [[ -w "$dest" ]]; then SUDO=""; else
            # current user does not have write access to install directory
            SUDO="sudo";
        fi
        $SUDO mkdir -p "$dest" &> /dev/null
        $SUDO install -c -v /tmp/tflint "$dest" &> /dev/null
        retVal=$?
        if [ $retVal -ne 0 ]; then
            echo -e "  * ${ERR}Error${NC}: Failed to install tflint"
            exit $retVal
        fi
        rm -f /tmp/tflint
    fi
    tflint --version &> /dev/null
    if [[ $? -ne 0 ]]; then
    echo -e "  * ${ERR}Error: tflint not found!${NC}"
    exit 1
else
    echo -e "  * ${OK}TFlint:${NC} `which tflint` - `tflint --version | head -n 1`"
fi
}
function install_terraform ()
{
    echo "- Terraform checks:"
    if ! command -v terraform &> /dev/null || [ "$OVERRIDE" == "true" ];  then
        echo -e "  * ${INF}Terraform${NC}: terraform could not be found, installing."
        unzip -u $SCRIPT_DIRECTORY/install/terraform_1.3.0_linux_amd64.zip -d /tmp/ &> /dev/null
        dest="${INSTALL_PATH:-/usr/local/bin}/"
        echo -e "  * ${INF}Terraform${NC}: Installing terraform to ${OK}${dest}${NC}"
        if [[ -w "$dest" ]]; then SUDO=""; else
            # current user does not have write access to install directory
            SUDO="sudo";
        fi
        $SUDO mkdir -p "$dest"
        $SUDO install -c -v /tmp/terraform "$dest" &> /dev/null
        retVal=$?
        if [ $retVal -ne 0 ]; then
            echo "Failed to install terraform"
            exit $retVal
        fi
        rm -f /tmp/tflint  
    fi
    terraform --version &> /dev/null
    if [[ $? -ne 0 ]]; then
     echo -e "  * ${ERR}Terraform  not found:${OK} terraform not found or not in path!${NC}"
     exit 1
 else
     echo -e "  * ${OK}Terraform:${NC} `which terraform` - `terraform --version -json | jq -r '.terraform_version'`"
 fi
}

function install_checkov ()
{
  echo "- Checkov checks:"
    if ! command -v checkov &> /dev/null || [ "$OVERRIDE" == "true" ]; then
        echo -e "  * ${INF}Checkov:${NC} checkov could not be found, installing."
        sudo pip3 install --upgrade checkov requests &> /dev/null
    fi
    checkov --version &> /dev/null
    if [[ $? -ne 0 ]]; then
    echo -e "  * ${ERR}Error: checkov not found!${NC}"
    exit 1
else
    echo -e "  * ${OK}Checkov:${NC} `which checkov` - `checkov --version | head -n 1`"
fi
}

install_terraform
install_tflint
install_checkov
