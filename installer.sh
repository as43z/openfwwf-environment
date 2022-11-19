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
		SUCCESS=1
		sudo apt install -y $1 && SUCCESS=0
		echo_task $SUCCESS "sudo apt install -y $1"
	fi
}	

# Main deployment
while read package; do
	install_package $package
done <requirements