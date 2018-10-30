require './lib/docker_registry'

class DockerImagesController < ApplicationController
  before_action :authenticate_team!, only: [:my]
  before_action :authenticate_admin!, only: [:all]

  def my
    @problems = Problem.all
    begin
      @infos = @problems.map do |problem|
        DockerRegistry::get_latest_info(current_team.login_name, problem.exploit_container_name)
      end
    rescue => error
      @infos = []
      flash.now[:alert] = error
    end
  end

  def all
    @problems = Problem.all
    @teams = Team.all
    @infos = @problems.map do |problem|
      @teams.map do |team|
        DockerRegistry::get_latest_info(team.login_name, problem.exploit_container_name)
      end
    end
  end
end
