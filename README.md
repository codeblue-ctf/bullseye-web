# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

```sh
$ docker run -p 5000:5000 --rm -e REGISTRY_AUTH=htpasswd -e REGISTRY_AUTH_HTPASSWD_REALM=realm -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd -v "$(pwd)/auth:/auth" --name registry registry:2
```
