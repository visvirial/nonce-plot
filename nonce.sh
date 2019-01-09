#!/bin/bash

COIN_CLI=monacoin-cli

BLOCKS=$($COIN_CLI getblockcount)

START_BLOCK=$(expr 1 + $(tail -n1 nonce.csv | awk -F , '{print $1}'))

for i in `seq $START_BLOCK $BLOCKS`; do
	BLOCK_HASH=$($COIN_CLI getblockhash $i)
	NONCE=$($COIN_CLI getblock $BLOCK_HASH | jq .nonce)
	echo "$i,$NONCE" | tee -a nonce.csv
done

