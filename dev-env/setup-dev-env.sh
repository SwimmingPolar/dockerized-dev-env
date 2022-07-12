#!/bin/sh
PACKAGE_NAME="$(basename $0)"
REPOSITORY_FILE="repositories.txt"

# exit if unknown options
TEMP=$(getopt -o 'f:' --long 'file:' -n "$PACKAGE_NAME" -- "$@" 2>/dev/null)
if [ $? -ne 0 ]; then
	echo "usage: $PACKAGE_NAME -f,--file file_name_containing_repo_list"
	exit 1
fi
unset PACKANGE_NAME

# set parsed arguments
eval set -- "$TEMP"
unset TEMP

while true; do
	case "$1" in
		'-f'|'--file')
			REPOSITORY_FILE=$2
			shift 2
			continue
		;;
		'--')
			shift
			break
		;;
		*)
			echo 'internal error!' >&2
			exit 1
		;;
	esac
done

# check if file exists when given as argument
ls $REPOSITORY_FILE > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "$REPOSITORY_FILE does not exist" >&2
	exit 1
fi

# check for github cli and install
dpkg -l gh > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo '# Installing github cli'
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
	sudo apt-add-repository https://cli.github.com/packages
	sudo apt update
	sudo apt -y install gh
	echo '# Github cli installation completed'
fi

# check git hub cli auth status
echo '# Checking github cli credential'
gh auth status
if [ $? -ne 0 ]; then
	gh auth login
fi

CURRENT_DIR="$(pwd)"
cd ..
# read repositories list and clone
cat "$CURRENT_DIR/$REPOSITORY_FILE" | xargs -I{} git clone {}

unset CURRENT_DIR
unset REPOSITORY_FILE
