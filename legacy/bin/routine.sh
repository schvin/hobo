#!/bin/sh

cd ~/projects/q/dashboard && git pull origin main && git pull origin main && git push origin main
cd ~/projects/q/dashboard/routine-maintenance && ef routine-maintenance.json
cd ~/projects/q/dashboard && git push origin main && git push origin main
