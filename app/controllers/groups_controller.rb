class GroupsController < ApplicationController
  before_action :authenticate_user!, :authenticate_admin
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
    @users = User.where()
  end

  def create
      @group = Group.new(group_params)

    if @group.save
      students = params[:group][:user_ids]
      students.pop
      students.each do |user_id|
        Usergroup.create(user_id: user_id, group_id: @group.id)
      end
      flash[:success] = "group added."
      redirect_to groups_path
    else
      flash[:alert] = @group.errors.full_messages.join(".  ")
      render :new
    end
  end

  def edit
      @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    Usergroup.where(group_id: @group.id).destroy_all
    if @group.update_attributes(group_params)
      students = params[:group][:user_ids]
      students.pop
      students.each do |user_id|
        Usergroup.create(user_id: user_id, group_id: @group.id)
      end
      flash[:success] = 'Your edits were saved!'
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to groups_path
  end

  def show
    group = Group.find(params[:id])
    info = {}
    info[:name] = group.name
    info[:users] = []
    group.users.each do |student|
      info[:users] << [ student.name]
    end
    render json: info
  end

  def show_stats
    @group = Group.find(params[:id])
  end

  private

  def group_params
    params.require(:group).permit(
      :name, :user_id
    )
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
