#!/bin/bash

# $1 host name
# $2 ngrok fqdn

origin_ip=`dig +short $1`

curl -H "Host: $1" "http://localhost:8080/createConf?origin_ip_url=https://${origin_ip}&ngrok_fqdn=$2"