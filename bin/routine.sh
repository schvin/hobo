#!/bin/sh

cd ~/projects/q/dashboard && git pull origin master && git pull upstream master && git push origin master
cd ~/projects/q/dashboard/routine-maintenance && ef routine-maintenance.json
cd ~/projects/q/dashboard && git push origin master && git push upstream master
