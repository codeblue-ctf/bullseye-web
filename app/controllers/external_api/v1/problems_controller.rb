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
    @images = Image.where(
      team_id: current_team.id,
      problem_id: @problem.id
    ).order("uploaded_at DESC")

    render json: {
      problem: @problem,
      # TODO: make it faster by using .where(is_manifest: true) instead of filter
      images: @images.filter{ |image| image.manifest? }.map{ |image|
        {
            tag: image.tag,
            problem_id: image.problem_id,
            team_id: image.team_id,
            uploaded_at: image.uploaded_at,
            created_at: image.created_at,
            image_digest: image.image_digest
        }
      }
    }
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.where(hidden: [false, nil]).find(params[:id])
    end
end
