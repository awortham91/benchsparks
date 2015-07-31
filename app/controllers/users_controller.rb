class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    authenticate_admin
    if params[:q] == nil
      @users = User.order(:name).where(admin:false)
    elsif params[:q] == 'percent'
      @users = User.order_by_correct_answer_percentage
    else
      @users = User.joins(:userquestionstat).order("userquestionstats.#{params[:q]}")
    end
  end

  def show
    if params[:id].to_i == current_user.id
      @user = User.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if (current_user.id == @user.id) || (current_user.admin?)
      if @user.update(user_params)
        flash[:success] = "Profile updated."
        redirect_to user_path(@user)
      else
        flash[:alert] = @user.errors.full_messages.join(".  ")
        render :edit
      end
    else
      flash[:alert] = "You don't have permission to edit that user."
      redirect_to spots_path
    end
  end

  def add_admin
    authenticate_admin
    user = User.find(params[:id])
    user.admin = true
    user.save
    redirect_to admins_path
  end

  def remove_admin
    authenticate_admin
    user = User.find(params[:id])
    user.admin = false
    user.save
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
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
