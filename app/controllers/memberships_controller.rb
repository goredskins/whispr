class MembershipsController < ApplicationController
  before_action :signed_in_user

  def create
    @group = Group.find(params[:membership][:group_id])
    current_user.follow!(@group)
    respond_to do |format|
      format.html { redirect_to @group }
      format.js
    end
  end

  def destroy
    @group = Membership.find(params[:id]).group
    current_user.unfollow!(@group)
    redirect_to @group
  end
end