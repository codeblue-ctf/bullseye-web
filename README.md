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
$ docker run -p 5000:5000 --rm -e REGISTRY_AUTH=token -e REGISTRY_AUTH_TOKEN_REALM=http://localhost:3000/auth -e REGISTRY_AUTH_TOKEN_SERVICE=registry -e REGISTRY_AUTH_TOKEN_ISSUER=bulls_eye -e REGISTRY_AUTH_TOKEN_ROOTCERTBUNDLE=/certs/registry-auth.crt -v "$(pwd)/certs:/certs" registry:2
```
