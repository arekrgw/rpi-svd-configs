#!/bin/bash

sudo apt-get install supervisor -y

sudo sed -i -e 's/chmod=[0-9][0-9][0-9][0-9]/chmod=0770/' -e '/chmod=[0-9][0-9][0-9][0-9]/a chown=root:pi' /etc/supervisor/supervisord.conf