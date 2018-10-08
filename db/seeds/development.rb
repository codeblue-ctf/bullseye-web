Admin.create(
  email: 'admin@localhost',
  password: 'password'
)
Team.create(
  email: 'team1@localhost',
  password: 'password',
  name: 'team1',
  reset_password_token: 'token'
)
Problem.create(
  title: 'sanity-check',
  statement: 'sanity-check'
)
