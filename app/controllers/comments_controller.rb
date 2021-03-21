class CommentsController < ApplicationController
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
    @comment = Comment.find(params[:id])
    @redirect = params[:comment][:redirect]
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "Successfully updated comment"

      comment_redirect(@comment)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    post = comment.post
    comment.destroy
    flash[:notice] = "Successfully deleted comment"
    
    comment_redirect(comment)
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
end