class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
  end

  def new
  end
end
