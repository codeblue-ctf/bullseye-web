class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show]

  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.all
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
  end
end
