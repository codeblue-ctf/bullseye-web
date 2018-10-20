class Api::V1::ScheduleResultsController < ApiController
  def submit
    # Register score
    ScheduleResult.create(
      schedule_id: params[:schedule_id],
      score: params[:score],
      error: params[:error]
    )
  end
end
