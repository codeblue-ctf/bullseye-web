Admin.find_or_create_by(login_name: 'admin') do |admin|
  admin.update(
    password: 'password'
  )
end

Team.find_or_create_by(login_name: 'team01') do |team|
  team.update(
    password: 'password',
    name: 'team1'
  )
end

Problem.find_or_create_by(
  title: 'sanity-check',
  statement: 'sanity-check'
)
