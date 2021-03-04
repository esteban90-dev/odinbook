class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)
    comment.commenter = current_user

    if comment.save
      post.user.notifications.create(message: "#{comment.commenter.name} commented on your #{post_link(post)}")
      redirect_to user_profile_path(post.user.id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def post_link(post)
    "#{view_context.link_to("post", user_profile_path(post.user.id) + "##{post.id}", data: { turbolinks: false })}"
  end
end