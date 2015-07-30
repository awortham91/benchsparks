class AdminsController < ApplicationController
  before_action :authenticate_user!, :authenticate_admin
  def index
    @users = User.where(admin:true)
  end

  def new
    @users = User.where(admin:false)
  end

  protected

  def authenticate_admin
    if current_user.admin?
      return true
    else
      flash[:error] = 'You are not allowed there!'
      redirect_to benchsparks_path
    end
  end
end
