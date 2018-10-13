require './lib/docker_registry'

class LogsController < ApplicationController
  before_action :authenticate_team!
  def submit_log
    problems = Problem.all
    @infos = problems.map do |problem|
      DockerRegistry::get_latest_info(current_team.name, problem.exploit_container_name)
    end
  end
end
