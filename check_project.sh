# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    check_project.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jatan <jatan@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/14 03:03:50 by jatan             #+#    #+#              #
#    Updated: 2022/06/14 03:08:43 by jatan            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

read -p $(echo "Insert vogsphere repo: ") vogsphereLink
read -p $(echo "Insert path to working repo: ") workingPath

git clone $vogsphereLink check_repo
cd check_repo
norminette *.c */*.c */*/*.c
git status
git log -3

cd $workingPath
norminette *.c */*.c */*/*.c
git status
git log -3
