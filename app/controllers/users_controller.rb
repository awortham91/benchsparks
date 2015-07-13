class UsersController < ApplicationController
before_action :authenticate_user!, :authenticate_level
  def index

  end

  def show
    @number = params[:id]
  end

  protected

  def authenticate_level
    if(current_user.benchspark >= params[:id].to_i)
      return true
    else
      redirect_to users_path
    end
  end
end
