class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    post.likes.create(liker: current_user)
    post.user.notifications.create(message: "#{current_user.name} liked your #{view_context.link_to("post", user_profile_path(post.user.id) + "##{post.id}", data: { turbolinks: false } ) }")
    redirect_to user_profile_path(post.user.id)
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    
    redirect_to user_profile_path(like.post.user)
  end
end