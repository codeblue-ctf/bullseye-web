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

### Docker Registry

```sh
$ docker run -p 5000:5000 --rm -e REGISTRY_AUTH=htpasswd -e REGISTRY_AUTH_HTPASSWD_REALM=realm -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd -v "$(pwd)/db/auth:/auth" --name registry registry:2
```
