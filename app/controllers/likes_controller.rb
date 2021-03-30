class LikesController < ApplicationController
  before_action :authorize_destroy, only: :destroy
  before_action :authorize_create, only: :create
  before_action :check_profile_completion

  def create
    post = Post.find(params[:post_id])
    like = post.likes.new(liker: current_user)

    if like.save
      if post.user != current_user
        post.user.notifications.create(message: "#{current_user.name} liked your #{post_link(post)} ")
      end
      post_like_redirect(post)
    else
      unauthorized
    end
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
    #only permit the liker to destroy (unlike) a like
    like = Like.find(params[:id])
    if like.liker != current_user
      unauthorized
    end
  end

  def authorize_create
    #only permit a user to like a post that belongs to themselves or their friends
    post = Post.find(params[:post_id])
    unless current_user.friends.include?(post.user) || current_user == post.user
      unauthorized
    end
  end
end