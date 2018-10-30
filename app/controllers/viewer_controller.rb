class ViewerController < ApplicationController
  before_action :authenticate_admin!
  layout 'viewer'

  def index
  end

  def play
  end
end
