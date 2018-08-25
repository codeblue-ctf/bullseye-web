# README


## System dependencies

- ruby 2.5.1p57

## Configuration

```sh
$ bundle install
```

### Database initialization

```sh
$ rails db:create
$ rails db:migrate
```

### Generate htpasswd for Docker Registry

Do it after create the teams

```sh
$ rake generate_htpasswd:from_teams
```

### Generate server certificate for Docker Registry Auth

```sh
$ openssl req -nodes -newkey rsa:4096 -keyout config/certs/server.key -out config/certs/server.csr -subj "/CN=dockerauth"
$ openssl x509 -in config/certs/server.csr -out config/certs/server.crt -req -signkey config/certs/server.key -days 3650
```

## How to run the test suite

No test suites...

## Services (job queues, cache servers, search engines, etc.)

- Bulls Eye Web (including admin CMS)
- Bulls Eye Runner
- Docker Registry

## Deployment instructions

### Bulls Eye Web

```sh
$ rails start
```

### Docker Registry & Docker Registry Auth

```sh
$ dcoker-compose up
```
