#!/bin/bash
if [ ! -d "/home/${USER}/data" ]; then
        mkdir ~/data
fi

if [ ! -d "/home/${USER}/data/portainer" ]; then
	mkdir ~/data/portainer
fi