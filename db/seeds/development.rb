Admin.find_or_create_by(login_name: 'admin') do |admin|
  admin.update(
    password: 'password'
  )
end

team = Team.find_or_create_by(login_name: 'team01') do |team|
  team.update(
    password: 'password',
    name: 'team1',
    email: 'dummy@example.test'
  )
end

problem = Problem.find_or_create_by(
  title: 'sanity-check',
  statement: 'sanity-check',
  exploit_container_name: 'sanity-check',
  calc_formula: '1000*succeeded/(succeeded+failed)'
)

schedule = Schedule.find_or_create_by(
  team: team,
  problem: problem,
  start_at: Time.now,
  finish_at: Time.now + 60*10,
  interval: 30,
  runner_host: "localhost:3001"
)

schedule_result = ScheduleResult.find_or_create_by(
  schedule_uuid: "a05f5832-17e2-4f61-8867-bff77077b5e7",
  schedule: schedule,
)

schedule_result.update(
  succeeded: 100,
  failed: 10,
  runner_started_at: Time.now,
  runner_finished_at: Time.now + 60
)
