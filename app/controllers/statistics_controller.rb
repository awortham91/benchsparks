class StatisticsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.all
    @levels = []
    Level.all.each do |lev|
      level_name = lev.level
      little_array = Timed_challenge.where(level_id: lev.id).order(:score).reverse
      if little_array.count > 10
        little_array = little_array.first(10)
      end
    @levels << ([level_name, little_array]).flatten
    end
  end

  def show
    if current_user.id == params[:id].to_i || current_user.admin == true
      @stats = Userquestionstat.find_or_create_by user: params[:id]
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
    else
      redirect_to statistics_path
    end
  end
end
