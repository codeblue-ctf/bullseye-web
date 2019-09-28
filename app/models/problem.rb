class Problem < ApplicationRecord
  has_many :schedule

  validates :calc_formula, presence: true

  # XXX: what's this???
  before_save do |record|
    if record.docker_compose_changed? then
      begin
        record.docker_compose % {
          team: "",
          exploit: "",
          problem: ""
        }
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
