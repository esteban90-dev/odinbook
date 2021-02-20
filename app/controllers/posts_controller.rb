class PostsController < ApplicationController
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:notice] = "Successfully made a post"
      redirect_to user_profile_path(current_user.id)
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :picture)
  end
end