Admin.create(
  email: 'admin@localhost',
  password: 'password'
)
Team.create(
  email: 'team1@localhost',
  password: 'password',
  name: 'team1',
  docker_registry_token: 'token'
)
Problem.create(
  title: 'sanity-check',
  statement: 'sanity-check'
)
