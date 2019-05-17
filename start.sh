#!/bin/bash

# Copyright 2019 Finiz Open Source Software

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Check NODE_PORT variable is exist

if [[ -z "${NODE_PORT}" ]]; then
  NODE_PORT="3000"
else
  NODE_PORT="${NODE_PORT}"
fi

# Map NODE_PORT to Nginx default.conf

sed -i "s/___NODE_PORT___/$NODE_PORT/g" /etc/nginx/conf.d/default.conf

# Update nginx to match worker_processes to no. of cpu's
procs=$(cat /proc/cpuinfo |grep processor | wc -l)
sed -i -e "s/worker_processes  1/worker_processes $procs/" /etc/nginx/nginx.conf
cat /etc/nginx/conf.d/default.conf

# Always chown webroot for better mounting
mkdir -p /usr/share/nginx/html
chown -Rf nginx.nginx /usr/share/nginx/html

# Start supervisord and services

if [[ -z "${NODE_MODE}" ]]; then
  NODE_MODE="prod"
else
  NODE_MODE="${NODE_MODE}"
fi

# Create Nginx pid
mkdir -p /run/nginx

/usr/bin/supervisord -n -c /etc/supervisord.conf
