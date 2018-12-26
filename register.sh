# fqdn取得

# digでのIPを自動取得

curl -H "Host: ${host}" "http://localhost:8080/createConf?ngrok_fqdn=${ngrok_fqdn}&origin_ip_url=https://${origin_ip}"