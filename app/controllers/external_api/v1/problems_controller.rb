class ExternalApi::V1::ProblemsController < ExternalApiController
  #before_action :authenticate_team!
  before_action :set_problem, only: [:show]

  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.where(hidden: [false, nil])

    render json: { problems: @problems }
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    @images = Image.where(
      team_id: current_team.id,
      problem_id: @problem.id
    ).order("uploaded_at DESC")
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.where(hidden: [false, nil]).find(params[:id])
    end
end
