#!/bin/bash

# ---------------------------------------------------------------------------------------------------------------------
# Help for shell scripts
# ---------------------------------------------------------------------------------------------------------------------
help()
{
    for i in {1..100}; do echo -n -; done
    echo ""
    echo " Help for `basename $0` "
    for i in {1..100}; do echo -n -; done
    echo
    echo "install.sh : installs necessary tools (terraform, tflint, checkov, inspec)"
    echo
    echo "-o Overide local version"
}