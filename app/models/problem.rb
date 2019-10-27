class Problem < ApplicationRecord
  validates :calc_formula, presence: true
  validates :flag_template, presence: true, allow_blank: false

  # XXX: validate docker compose file
  before_save do |record|
    if record.docker_compose_changed? then
      begin
        DockerComposeTemplate::render(record.docker_compose, {
          team: ""
        })
      rescue KeyError => e
        raise ActiveRecord::ValidationError, "#{e}"
      end
    end
  end

  def team_docker_compose(team)
    docker_compose_params = {
      team: team[:login_name]
    }
    DockerComposeTemplate::render(self.docker_compose, docker_compose_params)
  end
end
