#!/bin/bash --login

## References:
# https://stackoverflow.com/questions/1988249/how-do-i-use-su-to-execute-the-rest-of-the-bash-script-as-that-user


# If needed, create a new environment
#conda create -y -n envname

# Add a new user for "right" uid
adduser --disabled-password --gecos "Default user" --uid 1001 user

# Run by a non-root user
sudo -i -u user bash <<EOF
source activate simpeg
conda info
conda list
python -c "import SimPEG; print('Great!')"
EOF

