#!/bin/bash

START_BLOCK=$(expr 1 + $(tail -n1 nonce_eth.csv | awk -F , '{print $1}'))

node ./nonce_eth.js $START_BLOCK | tee -a nonce_eth.csv

