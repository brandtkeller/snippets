#!/bin/bash

# Purpose: I have a RPI Zero W attached to multiple relays which control my air compressor for my garage
# (it's remotely located in a side-shed)

# The RPI is running a spring-boot REST API server for controlling the Compressor and an electronic purge valve for condensation.

#Usage ./compressor.sh 1 true (Compressor ON)

curl -X PUT 192.168.0.214:8080/relays/$1 -H 'content-type:application/json' -d '{"id":"'"$1"'", "state":"'"$2"'"}'