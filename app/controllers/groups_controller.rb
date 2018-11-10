class GroupsController < ApplicationController
  before_action :verify_logged_in_user
  before_action :force_json, only: :autocomplete_groups

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
  
  def join
    @group = Group.find(params[:group])
    @user = User.find(params[:user])
    @membership = Membership.new
    @membership.group_id = @group.id
    @membership.user_id = @user.id
    if @membership.save
      flash[:success] = "Successfully joined the '#{@group.name}' group"
    else
      flash[:error] = "Couldn't join the '#{@group.name}' group"
    end
    redirect_to groups_path
  end
  
  def leave
    @group = Group.find(params[:group])
    @user = User.find(params[:user])
    @membership= Membership.find_by(user_id: @user.id, group_id: @group.id)
    if @membership.destroy
      flash[:success] = "Successfully left the '#{@group.name}' group"
    else
      flash[:error] = "Couldn't leave the '#{@group.name}' group"
    end
    redirect_to groups_path
  end
  
  def search_groups
    @groups_found = Group.ransack(name_cont: params[:groups_q]).result(distinct: true)
  end

  def autocomplete_groups
      @groups_found = Group.ransack(name_cont: params[:groups_q]).result(distinct: true)
        respond_to do |format|
        format.html{}
        format.json{
          @groups_found = @groups_found.limit(5)
        }
      end
  end
  private
  
  def group_params_validator
    params.require(:group).permit(:name, :description, :isPublic,:owner_id)
  end
end
