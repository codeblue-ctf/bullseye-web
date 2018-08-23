require 'bcrypt'

namespace :generate_htpasswd do
  task :from_teams => :environment do
    htpasswd_file = './db/auth/htpasswd'
    content = Team.all.map { |team|
      password = BCrypt::Password.create(team.docker_registry_token)
      "#{team.email}:#{password}"
    }.join("\n")
    File.write(htpasswd_file, content)

    puts "#{htpasswd_file} is updated"
    puts "here is new htpasswd:"
    puts content
  end
end
