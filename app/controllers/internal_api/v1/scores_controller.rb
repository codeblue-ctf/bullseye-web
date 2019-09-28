class InternalApi::V1::ScoresController < InternalApiController
  def submit
    Score.create(score_params)
  end

  private
  def score_params
    params.require(:score).permit(:image_digest, :problem_id, :team_id, :succeeded, :failed, :log, :runner_started_at, :runner_finished_at)
  end
end
