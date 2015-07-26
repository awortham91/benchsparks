class TimedpracticesController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def create
    new_score = Timed_challenge.new
    new_score.user_id = current_user.id
    new_score.score = (params[:score].to_i)
    if params[:level] == '1'
      lev = Level.find_or_create_by!(level: "easy")
      new_score.level_id = lev.id
    elsif params[:level] == '2'
      lev = Level.find_or_create_by!(level: "medium")
      new_score.level_id = lev.id
    elsif params[:level] == '3'
      lev = Level.find_or_create_by!(level: "hard")
      new_score.level_id = lev.id
    elsif params[:level] == '4'
      lev = Level.find_or_create_by!(level: "master")
      new_score.level_id = lev.id
    end
    if new_score.save
      render json: { statusText: "Level Added." }
    else
      render json: {statusText: "something went wrong"}
    end
  end
end
