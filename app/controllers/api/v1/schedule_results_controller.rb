class Api::V1::ScheduleResultsController < ApiController
  def submit
    # Register score
    ScheduleResult.create(schedule_result_params)
  end

  private
  def schedule_result_params
    params.require(:schedule_result).permit(:schedule_id, :score, :error, :start_at, :finished_at)
  end
end
