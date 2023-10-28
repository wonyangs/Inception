#!/bin/bash
if [ ! -d "/home/${USER}/data" ]; then
        mkdir ~/data
fi

if [ ! -d "/home/${USER}/data/website" ]; then
	mkdir ~/data/website
fi
