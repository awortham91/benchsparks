class UsersController < ApplicationController
  before_action :authenticate_user!, :authenticate_admin
  def index
    if params[:q] == nil
      @users = User.order(:name).where(admin:false)
    elsif params[:q] == 'percent'
      @users = User.joins(:userquestionstat).order("userquestionstats.correct / userquestionstats.total_questions")
    else
      @users = User.joins(:userquestionstat).order("userquestionstats.#{params[:q]}")
    end
  end

  protected

  def authenticate_admin
    if current_user.admin?
      return true
    else
      flash[:error] = 'You are not allowed there!'
      redirect_to root_path
    end
  end
end
