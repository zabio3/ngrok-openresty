# ngrok-openresty

ngrok-openresty is a tool for to verify 

Requirement
---

 - ngrok v2
 - docker 18.0++
 - docker-compose 1.23++

Usage
---

Start docker container : default listening on port 8080:

```
$ cd ./ngrok-openresty
$ docker-compose build
$ docker-compose up
```

Start ngrok for getting 'ngrok_fqdn'
 - '8080' is open port by using docker-compose

```
$ ngrok http 8080
```

Regist verify fqdn

```
$ ./register.sh <target fqdn> <output ngrok fqdn>
```

Feedbacks
---

Report issues/questions/feature requests on GitHub Issues.

Pull requests are very welcome!