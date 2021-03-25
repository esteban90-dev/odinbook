class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_create, only: :create
  before_action :authorize_edit_update_destroy, only: [:edit, :update, :destroy]

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)
    comment.commenter = current_user

    if comment.save
      if post.user != current_user
        post.user.notifications.create(message: "#{comment.commenter.name} commented on your #{post_link(post)}")
      end
      flash[:notice] = "Successfully created comment"

      comment_redirect(comment)
    end
  end

  def edit
    @redirect = params[:comment][:redirect]
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "Successfully updated comment"

      comment_redirect(@comment)
    end
  end

  def destroy
    post = @comment.post
    @comment.destroy
    flash[:notice] = "Successfully deleted comment"
    
    comment_redirect(@comment)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def post_link(post)
    "#{view_context.link_to("post", user_profile_path(post.user.id) + "##{post.id}", data: { turbolinks: false })}"
  end

  def comment_redirect(comment)
    if params[:comment][:redirect] == "timeline"
      redirect_to posts_path
    else
      redirect_to user_profile_path(comment.post.user.id) + "##{comment.post.id}"
    end
  end

  def authorize_create
    unless Post.find(params[:post_id]).user.friends.include?(current_user) || Post.find(params[:post_id]).user == current_user
      unauthorized
    end
  end

  def authorize_edit_update_destroy
    unless Comment.find(params[:id]).commenter == current_user
      unauthorized
    end
  end

  def unauthorized
    flash[:alert] = "this action is not permitted"
    redirect_to posts_path
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end