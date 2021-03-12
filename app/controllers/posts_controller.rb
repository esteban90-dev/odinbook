class PostsController < ApplicationController
  def index
    friend_ids = current_user.friends.pluck(:id)
    valid_ids = (friend_ids << current_user.id).map(&:to_i)
    @posts = Post.where(user_id: valid_ids).reverse_order.limit(15)
  end

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
      redirect_to user_profile_path(post.user.id) + "##{post.id}"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "Post successfully destroyed"
    redirect_to user_profile_path(current_user.id)
  end

  private

  def post_params
    params.require(:post).permit(:body, :picture)
  end
end