class GroupsController < ApplicationController
  before_action :verify_logged_in_user
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = current_user.groups.new
  end
  
  def create
    @group = current_user.groups.create(group_params_validator)
    @group.owner_id = current_user.id
    
    if @group.save 
      flash[:success] = "Your new group is successfully created"
      redirect_to group_path(@group)
    else
      render 'new'
    end
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group_users = @group.users
    @group_users.destroy
    @group.destroy
    flash[:success] = "Group has been successfully deleted"
    redirect_to groups_path 
  end
  private
  
  def group_params_validator
    params.require(:group).permit(:name, :description, :isPublic,:owner_id)
  end
end
