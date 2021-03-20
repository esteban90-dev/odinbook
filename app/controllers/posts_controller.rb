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

      post_redirect(post)
    end
  end

  def edit
    @post = Post.find(params[:id])
    @redirect = params[:redirect]
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      flash[:notice] = "Successfully updated post"
  
      post_redirect(post)
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "Post successfully destroyed"
    post_redirect(post)
  end

  private

  def post_params
    params.require(:post).permit(:body, :picture)
  end

  def post_redirect(post)
    if params[:post][:redirect] == "timeline"
      redirect_to posts_path
    else
      redirect_to user_profile_path(post.user.id) + "##{post.id}"
    end
  end

end