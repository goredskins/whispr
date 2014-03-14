class CommentsController < ApplicationController
  #before_action :signed_in_user, only: [:create, :destroy]

  def create
    if signed_in?
      @comment = current_user.comments.build(comment_params)
    else
      @comment = User.find(1).comments.build(comment_params)
    end
    @previous = @comment.post.comments.last

    respond_to do |format|
        format.html {
          if @comment.save
            flash[:success] = "Comment created!"
            redirect_to @comment.post.group
          else
           redirect_to :back
          end
        }
        format.js {
          if @previous != nil and @previous.user_id == @comment.user_id #User writes two comments in a row'
            @previous.secondary_content << @comment.content
            @previous.save
            @new = false
          else
            @new = true
            @comment.save
          end
        }
     end
  end

  def destroy
  end

  def index
    @comments = Comment.all
  end
  
  def show
  end

  private

    def comment_params
      params.require(:comment).permit(:post_id, :content, :sticker_id)
    end
end