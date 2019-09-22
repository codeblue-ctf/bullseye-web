# README


## System dependencies

- ruby 2.6.4

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

## Deployment instructions

### Bulls Eye Web

```sh
$ rails start
```
