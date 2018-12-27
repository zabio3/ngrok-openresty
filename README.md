# ngrok-openresty

ngrok-openresty is a tool that makes it easy to set proxy settings and publish them on the Internet.

There are cases where you want to make simple tuning and publish it on the Internet and check the behavior.

For example, checking with [PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/).

Requirement
---

 - docker 18.0++
 - docker-compose 1.23++

Usage
---

##### Start docker container 

```
$ cd ./ngrok-openresty
$ docker-compose build
$ docker network create ngrok_network
$ docker-compose up
```

##### Getting ngrok fqdn

Open http://localhost:4040 in a web browser to inspect request details.

Copy the described fqdn ( example 375a84fc.ngrok.io )
 
##### Regist verify fqdn

```
$ ./register.sh <target fqdn> <output ngrok fqdn>
```

example

```
$ ./register.sh zabio3.github.io 375a84fc.ngrok.io
```

##### show verify web site

access the 'ngrok_fqdn'


Feedbacks
---

Report issues/questions/feature requests on GitHub Issues.

Pull requests are very welcome!