class ExternalApi::V1::ProblemsController < ExternalApiController
  before_action :authenticate_team!
  before_action :set_problem, only: [:show]

  # GET /problems
  # GET /problems.json
  def index
    problems = Problem.where(hidden: [false, nil])
      .map { |p|
        json = p.as_json
        json['docker_compose'] = p.team_docker_compose(current_team)
        json
      }

    render json: { problems: problems }
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    scores =  Score.where(
      team_login_name: current_team.login_name,
      problem_name: @problem.exploit_container_name
    ).order("runner_started_at DESC")

    problem = @problem.as_json
    problem['docker_compose'] = @problem.team_docker_compose(current_team)

    render json: {
      problem: problem,
      scores: scores.map{ |score|
        calclated_score = score.calc_score(@problem.calc_formula)
        {
            succeeded: score.succeeded,
            calclated_score: calclated_score,
            problem_id: score.problem_name,
            team_id: score.team_login_name,
            runner_started_at: score.runner_started_at,
            created_at: score.created_at,
            image_digest: score.image_digest
        }
      }
    }
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.where(hidden: [false, nil]).find(params[:id])
    end
end
