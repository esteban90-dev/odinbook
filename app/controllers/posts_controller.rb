class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]
  before_action :check_profile_completion
  before_action :resize_picture, only: [:create, :update]

  def index
    friend_ids = current_user.friends.pluck(:id)
    valid_ids = (friend_ids << current_user.id).map(&:to_i)
    @posts = Post.where(user_id: valid_ids).reverse_order.limit(15)
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "Successfully made a post"
      post_redirect(@post)
    else
      @redirect = params[:post][:redirect]
      render :new
    end
  end

  def edit
    @redirect = params[:post][:redirect]
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Successfully updated post"
      post_redirect(@post)
    else
      @redirect = params[:post][:redirect]
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post successfully destroyed"
    post_redirect(@post)
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

  def authorize
    if @post.user != current_user
      unauthorized
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def resize_picture
    path = post_params[:picture].tempfile.path
    ImageProcessing::MiniMagick.source(path)
        .resize_to_limit(400,400)
        .call(destination: path)
  end
end