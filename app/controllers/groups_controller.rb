class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :since, :infinite]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show


    @membership = current_user.following?(@group)
    if @membership
      @new_posts = @group.posts.where("created_at > :update", {:update => @membership.last_view})
      @membership.last_view = Time.now
      @membership.save

      @new_posts.each do |post|
        @membership.posts << post
      end
    end
    @post = current_user.posts.build if signed_in?
    @comment = current_user.comments.build if signed_in?
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  def since 
    @membership = current_user.following?(@group)
    @comment = current_user.comments.build if signed_in?

    @posts = @group.posts.where("posts.created_at > :update", {:update => @membership.last_view})
    @comments = @group.comments.where("comments.updated_at > :update AND comments.user_id != :user", {:update => @membership.last_view, :user => current_user.id})

    unless @posts.empty? and @comments.empty?
      @membership.last_view = Time.now
      @membership.save
    end

    respond_to do |format|
      format.js
    end
  end

  def infinite
    @comment = current_user.comments.build if signed_in?
    @start = group_params[:start].to_i
    @posts = @group.posts[@start..-1].take(8)

    respond_to do |format|
      format.js
    end

  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :start)
    end
end
