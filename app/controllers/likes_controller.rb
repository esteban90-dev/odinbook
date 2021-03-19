class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    post.likes.create(liker: current_user)

    if post.user != current_user
      post.user.notifications.create(message: "#{current_user.name} liked your #{post_link(post)} ")
    end

    if request.referer.include?("profile")
      redirect_to user_profile_path(post.user.id)
    else
      redirect_to posts_path
    end
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy

    redirect_to user_profile_path(like.post.user)
  end

  private

  def post_link(post)
    "#{view_context.link_to("post", user_profile_path(post.user.id) + "##{post.id}", data: { turbolinks: false })}"
  end
end