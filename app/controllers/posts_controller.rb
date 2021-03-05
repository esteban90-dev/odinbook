class PostsController < ApplicationController
  def create
    post = current_user.posts.new(post_params)

    if post.save
      flash[:notice] = "Successfully made a post"
      redirect_to user_profile_path(current_user.id) + "##{post.id}"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      flash[:notice] = "Successfully updated post"
      redirect_to user_profile_path(post.user.profile.id) + "##{post.id}"
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :picture)
  end
end