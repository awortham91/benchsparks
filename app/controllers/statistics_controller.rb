class StatisticsController < ApplicationController
  before_action :authenticate_user!

  def index
    @stats = Userquestionstat.find_or_create_by user: current_user
  end
end
