class LikesController < ApplicationController
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
    if request.referer.include?("profile")
      redirect_to user_profile_path(post.user.id)
    else
      redirect_to posts_path
    end
  end

end