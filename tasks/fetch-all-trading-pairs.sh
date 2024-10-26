#!/bin/bash

# Download all symbols from Spot, USD-M Futures and COIN-M Futures, into three separate files: `symbols.txt`, `um_symbols.txt` and `cm_symbols.txt`.
# Requires `jq` to be installed: https://stedolan.github.io/jq/
# Usage: ./fetch-all-trading-pairs.sh



# mkdir -p "$BASE_DATA_DIR"
# mkdir -p "$LOG_DIR"

curl -s -H 'Content-Type: application/json'  https://api.binance.com/api/v3/exchangeInfo | jq -r '.symbols | sort_by(.symbol) | .[] | .symbol' > "${BASE_DATA_DIR}spot_symbols.txt"

curl -s -H 'Content-Type: application/json'  https://fapi.binance.com/fapi/v1/exchangeInfo | jq -r '.symbols | sort_by(.symbol) | .[] | .symbol' > "${BASE_DATA_DIR}um_symbols.txt"

curl -s -H 'Content-Type: application/json'  https://dapi.binance.com/dapi/v1/exchangeInfo | jq -r '.symbols | sort_by(.symbol) | .[] | .symbol' > "${BASE_DATA_DIR}cm_symbols.txt"

# 在$LOG_DIRbase_data/{date}.log文件中，记录时间和下载的文件名称
echo "$(date) - Downloaded spot, um and cm symbols" >> "${LOG_DIR}$(date +%Y-%m-%d).log"