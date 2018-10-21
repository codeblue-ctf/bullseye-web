Admin.find_or_create_by(email: 'admin@localhost') do |admin|
  admin.update(
    password: 'password'
  )
end

Team.find_or_create_by(email: 'team1@localhost') do |team|
  team.update(
    password: 'password',
    name: 'team1',
    docker_registry_token: 'token'
  )
end

Problem.find_or_create_by(
  title: 'sanity-check',
  statement: 'sanity-check'
)
