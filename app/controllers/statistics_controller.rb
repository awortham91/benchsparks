class StatisticsController < ApplicationController
  before_action :authenticate_user!

  def index
    @stats = Userquestionstat.find_or_create_by user: current_user
    @levels = []
    Level.all.each do |lev|
      level_name = lev.level
      array = Timed_challenge.where(user_id: current_user.id, level_id: lev.id).order(:score).reverse
      if array.count < 3
        little_array = []
        array.each do |lever|
          little_array << lever.score
        end
        @levels << ([level_name, little_array]).flatten
      else
        @levels << [level_name, array[0].score, array[1].score, array[2].score]
      end
    end
  end
end
