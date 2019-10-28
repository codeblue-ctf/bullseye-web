class ViewerController < ApplicationController
  layout 'viewer'

  def index
  end

  def play
  end

  def table
  end

  def capture
    job_capture = RunnerMaster::get_job_capture(params[:id])
    send_data(job_capture, :disposition => 'inline', :type => 'video/mp4')
  end
end
