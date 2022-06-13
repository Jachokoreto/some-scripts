# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start_project.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jatan <jatan@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/14 01:21:05 by jatan             #+#    #+#              #
#    Updated: 2022/06/14 03:02:05 by jatan            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
#
# Copyright 2022 Jachokoreto
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Jachokoreto : Im not responsible for any damage :D

##########
# COLORS #
##########
RED="31m"
GREEN="32m"
YELLOW="33m"
CYAN="36m"
DEFAULT="\e["
BOLD="\e[1;"
ITALIC="\e[3;"
RESET="\e[0m"
ERROR="${DEFAULT}${RED}"
SUCCESS="${BOLD}${GREEN}"

# **************************************************************************** #
# Introduction
# This script will help you to make a directory and add the
# necessary github and vogsphere remote repo link
# Vogsphere will only be added if you are on a 42's iMac
# Recommend to use it when you are starting a project
# **************************************************************************** #

cat << EOF

+++++++++  START_NEW_PROJECT.SH  ++++++++

Hi, congratulations on starting a new project!!

This script needs a github repo created
(vogsphere is recommended to have)
If you are ready, let's get started!

EOF

# GET MODE
# To choose between adding two or one remote repo
# Will reprompt if input does not match
echo "Choose one mode:"
echo -e "${DEFAULT}${CYAN}[1] Add github repo only${RESET}"
echo -e "${DEFAULT}${CYAN}[2] Add both github repo and vogsphere repo${RESET}"
while true; do
    read -p "[1\2]: " mode
    case $mode in
        "1")
            echo -e "${SUCCESS}=== Add github repo only ===\n${RESET}"
            break
            ;;
        "2")
            echo -e "${SUCCESS}=== Add both github repo and vogsphere repo ===\n${RESET}"
            break
            ;;
         *)
            echo "Invalid input" >&2
    esac
done
# END

# GET PROJECT NAME
# Get prject name from user input, then use the iinput to make a directory
while true; do
    read -p "$(echo -e ${DEFAULT}${CYAN}Insert project name: ${RESET})" projectName
    if $(mkdir $projectName) 
    then
        break
    fi 
done
cd $projectName
echo -e "${SUCCESS}✅ $PWD : directory created${RESET}"
git init #initialize a git so that we can add git remote later
git checkout -b main #change branch to main, as master is the default one
echo
# END


#######################################
# Get repo link from user input
# GLOBALS:
#   githublink and vogspherelink
# ARGUMENTS:
#   Type of repo
# OUTPUTS:
#   set githublink or vogsphere depending on argument
#######################################
get_repo_link() {
    while true; do
        read -p "$(echo -e ${DEFAULT}${CYAN}Insert $1 repo ssh link : ${RESET})" inputLink
        case $1 in
            "github")
                # Check if the link matches the github format
                # This limits to github only
                if [[ $inputLink =~ ^git@github.com:[a-zA-Z0-9-]+\/[a-zA-Z0-9-]+\.git$ ]]; then
                # Example: git@github.com:githubusername/reponame.git
                    githublink=$inputLink
                    break
                else
                    echo -e "${ERROR}$1 link does not match${RESET}"
                fi
                ;;
            "vogsphere")
                # Check if the link matches the vogsphere format
                # This limits to github only
                if [[ $inputLink =~ ^git@vogsphere.42kl.edu.my:vogsphere\/[a-zA-Z0-9-]+$ ]]; then
                # Example: git@vogssphere.42kl.edu.my:vogsphere/intra-uuid-somerandomenumbers-intraid
                    vogspherelink=$inputLink
                    break
                else
                    echo -e "${ERROR}$1 link does not match${RESET}"
                fi
                ;;
        esac
    done
}

# GET GITHUB LINK
# Get link and add to git, then pull from github
get_repo_link github
git remote add github $githublink
echo -e "${SUCCESS}✅ Github remote repo added\n${RESET}"
echo -e "${DEFAULT}${YELLOW}Pulling commits from github remote repo . . .${RESET}"
git pull github main
echo -e "${SUCCESS}✅ Pulled from github\n${RESET}"
git log -3 --oneline | cat 
# END

# GET VOGSPHERE LINK if chosen
# Get link and add to git
if [[ $mode == "2" ]]
then
    get_repo_link vogsphere
    git remote add vogsphere $vogspherelink
    echo -e "${SUCCESS}✅ Vogsphere remote repo added\n${RESET}"
fi

echo -e "${BOLD}${YELLOW}Good luck and have fun!${RESET}"

