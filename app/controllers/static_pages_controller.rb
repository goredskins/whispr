class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@user = current_user
  		@user.feed_last_view = Time.now
  		@user.save
  		@posts = current_user.feed_items
  		@comment = @user.comments.build
  	end
  end

  def since
	@user = current_user
	
    @comment = @user.comments.build if signed_in?

    @posts = @user.feed_items.where("posts.created_at > :update", {:update => @user.feed_last_view})
    @comments = []
    @user.groups.each do |group|
    	group.comments.where("comments.created_at > :update AND comments.user_id != :user", {:update => @user.feed_last_view, :user => @user.id}).each do |comment|
    		@comments.append(comment)
    	end
    end

    unless @posts.empty? and @comments.empty?
    	@clone = User.find(@user.id)
    	@clone.feed_last_view = Time.now
		@clone.save
    end

    respond_to do |format|
      format.js
    end
  end

  def search
    @query = params.permit(:q)[:q]
    @results = Group.where("name like ?", "%#{@query}%").limit(10)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def help
  end
end
