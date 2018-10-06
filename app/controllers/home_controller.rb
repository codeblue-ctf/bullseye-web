class HomeController < ApplicationController
  before_action :authenticate_team!
  def index
  end
end
