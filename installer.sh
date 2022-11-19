#!/usr/bin/bash
#
#
# Environment Installer

# Sourcing
source ./assets.sh

# Functions

# echo_task
# Echoes a task with a code
# @param $1 - Code exit: 0 - OK, 1 - Failure
# @param $2 - Message to be displayed along side the TAG.
echo_task () {
	if [ "$#" -ne 2 ]; then
		echo -e "${YELLOW}WARN${RESET}: There has been a problem when calling echo_task. \nThis function needs 2 parameters:\n\t1) Exit Code: 0 - OK, 1 - BAD.\n\t2) Message"
	else
		local TAG="${RED}BAD"
		if [ "$1" -eq 0 ]; then
			TAG="${GREEN}OK"
		fi
		echo -e "[$TAG$RESET] \"$2\""
	fi
}

# install_package
# Installs a package from input
# @param $1 - package
install_package () {
	if [ $# -ne 1 ]; then
		echo -e "${YELLOW}WARN${RESET}: There has been a problem when calling install_package.\nThis function needs 1 paramenter:\n\t1) package - package to be installed."
	else
		local SUCCESS=1
		sudo apt install -y $1 && SUCCESS=0
		echo_task $SUCCESS "sudo apt install -y $1"
	fi
}

# clone_repo
# Clones a repository from a URL
# @param $1 - URL.
clone_repo () {
	if [ $# -ne 1 ]; then
		echo -e "${YELLOW}WARN${RESET}: There has been a problem when calling clone_repo.\nThis function needs 1 paramenter:\n\t1) url - URL of the package."
	else
		local SUCCESS=1
		git clone -C $HOME $1 && SUCCESS=0
		echo_task $SUCCESS "git clone -C $HOME $1"
	fi
}

# Main deployment
# Check who initialised the script
if [ "$(whoami)" == "root" ]; then 
	echo -e "$RED DO NOT RUN THIS SCRIPT AS ROOT!$RESET"
	exit 1
fi

# Install proper packages
sudo apt update
while read package; do
	install_package $package
done <requirements

# Clone the repos
while read repo; do
	clone_repo $repo
done <repos