class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_destroy, only: :destroy
  before_action :authorize_create, only: :create

  def create
    post = Post.find(params[:post_id])
    post.likes.create(liker: current_user)

    if post.user != current_user
      post.user.notifications.create(message: "#{current_user.name} liked your #{post_link(post)} ")
    end

    post_like_redirect(post)
  end

  def destroy
    like = Like.find(params[:id])
    post = like.post
    like.destroy
    
    post_like_redirect(post)
  end

  private

  def post_link(post)
    "#{view_context.link_to("post", user_profile_path(post.user.id) + "##{post.id}", data: { turbolinks: false })}"
  end

  def post_like_redirect(post)
    if params[:redirect] == "timeline"
      redirect_to posts_path
    else
      redirect_to user_profile_path(post.user.id)
    end
  end

  def authorize_destroy
    if Like.find(params[:id]).liker != current_user
      flash[:alert] = "this action is not permitted"
      redirect_to posts_path
    end
  end

  def authorize_create
    unless current_user.friends.include?(Post.find(params[:post_id]).user)
      flash[:alert] = "this action is not permitted"
      redirect_to posts_path
    end
  end

end