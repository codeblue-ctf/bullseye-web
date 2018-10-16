class ScheduleResultController < ApplicationController
  before_action :authenticate_runner

  def submit
    # Register score
    ScheduleResult.create(
      schedule_id: params[:schedule_id],
      score: params[:score],
      error: params[:error]
    )
  end

    def authenticate_runner
      # TODO: authenticate runner
    end
end
