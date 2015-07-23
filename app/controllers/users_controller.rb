class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.admin?
      @users = User.where(admin:false)
    else
      flash[:error] = 'You are not allowed there!'
      redirect_to root_path
    end
  end
end
