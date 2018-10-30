class InternalApi::V1::ScheduleResultsController < InternalApiController
  def submit
    # Register score
    schedule_result = ScheduleResult.find_by(schedule_uuid: schedule_result_params[:schedule_uuid])
    return unless schedule_result
    schedule_result.update(schedule_result_params)
  end

  private
  def schedule_result_params
    params.require(:schedule_result).permit(:schedule_uuid, :succeeded, :failed, :error, :start_at, :finished_at)
  end
end
