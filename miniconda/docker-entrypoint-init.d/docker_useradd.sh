#!/bin/bash --login

## References:
# https://stackoverflow.com/questions/1988249/how-do-i-use-su-to-execute-the-rest-of-the-bash-script-as-that-user

echo "===== Start useradd entrypoint ====="

# If needed, create a new environment
#conda create -y -n envname

# Add a new user for "right" uid
adduser --disabled-password --gecos "Default user" --uid 1001 user

# Run by a non-root user
runuser -u user -- conda init bash > /dev/null 2>&1  #runuser -l user -c 'conda init bash > /dev/null 2>&1'
sudo -i -u user bash <<EOF
source activate myenv
conda info
conda list
python -c "import os; print('We can run python!')"
EOF

echo "===== End useradd entrypoint ====="
