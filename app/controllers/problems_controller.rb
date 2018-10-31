class ProblemsController < ApplicationController
  before_action :authenticate_team!
  before_action :set_problem, only: [:show]

  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.where(hidden: [false, nil])
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.where(hidden: [false, nil]).find(params[:id])
    end
end
