class UsersController < ApplicationController
before_action :authenticate_user!, :authenticate_level
  def index

  end

  def show
    @number = params[:id]
  end

  def update
    @user = User.find(current_user.id)
    @user.benchspark += 1
    if @user.save
      render json: { statusText: "LevelUp!" }
    else
      render json: {statusText: "O no!"}
    end
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
