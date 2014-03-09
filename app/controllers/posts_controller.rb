class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def create
    if signed_in?
      @post = current_user.posts.build(micropost_params)
    else
      @post = User.find(1).posts.build(micropost_params)
    end
    if @post.save
      flash[:success] = "Post created!"
      redirect_to @post.group
    else
      render 'static_pages/home'
    end
  end

  def destroy
    group = @post.group
    if signed_in? and @post.user == current_user
      @post.destroy
    end
    respond_to do |format|
      format.html { redirect_to group }
      format.json { head :no_content }
    end
  end

  def index
    @posts = Post.all
  end
  
  def show
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
    def micropost_params
      params.require(:post).permit(:content, :group_id, :media, :media_type)
    end
end
