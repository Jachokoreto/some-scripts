# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start_project.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jatan <jatan@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/14 01:21:05 by jatan             #+#    #+#              #
#    Updated: 2022/06/14 02:11:42 by jatan            ###   ########.fr        #
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

echo "Hi, are you on 42 campus's iMac or personal computer?"
echo -e "${DEFAULT}${CYAN}[1] 42 campus's iMac\n[2] personal computer${RESET}"

while true; do
    read -p "[1\2]: " workingStation
    case $workingStation in
        "1")
            echo -e "${SUCCESS}=== Continuing on 42's iMac ===\n${RESET}"
            break
            ;;
        "2")
            echo "${SUCCESS}=== Continuing on personal computer ===\n${RESET}"
            break
            ;;
         *)
            echo "Invalid input" >&2
    esac
done

while true; do
    read -p "$(echo -e ${DEFAULT}${CYAN}Insert project name: ${RESET})" projectName
    if $(mkdir $projectName) 
    then
        break
    fi 
done
cd $projectName
echo -e "${SUCCESS}✅ $PWD : directory created\n${RESET}"

get_repo_link() {
    while true; do
        read -p "$(echo -e ${DEFAULT}${CYAN}Insert $1 repo ssh link : ${RESET})" inputLink
        case $1 in
            "github")
                if [[ $inputLink =~ ^git@github\.com:[a-zA-Z0-9-]+\/[a-zA-Z0-9-]+\.git$ ]]; then
                #Example: git@github.com:githubusername/reponame.git
                    githublink=$inputLink
                    break
                else
                    echo -e "${ERROR}$1 link does not match${RESET}"
                fi
                ;;
            "vogsphere")
                if [[ $inputLink =~ ^git@vogsphere.42kl.edu.my:vogsphere\/[a-zA-Z0-9-]+$ ]]; then
                #Example: git@vogssphere.42kl.edu.my:vogsphere/intra-uuid-somerandomenumbers-intraid
                    vogspherelink=$inputLink
                    break
                else
                    echo -e "${ERROR}$1 link does not match${RESET}"
                fi
                ;;
        esac
    done
}

get_repo_link github
git remote add github $githublink
echo -e "${SUCCESS}✅ Github remote repo added\n${RESET}"

if [[ $workingStation == "1" ]]
then
    get_repo_link vogsphere
    git remote add vogsphere $vogspherelink
    echo -e "${SUCCESS}✅ Vogsphere remote repo added\n${RESET}"
fi

git pull github main

