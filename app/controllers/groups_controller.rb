class GroupsController < ApplicationController
  before_action :authenticate_user!
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

  private

  def group_params
    params.require(:group).permit(
      :name, :user_id
    )
  end
end
