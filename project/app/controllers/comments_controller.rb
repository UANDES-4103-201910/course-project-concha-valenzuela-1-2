class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    puts @comment.errors.messages()
    redirect_to post_path(@post)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:description).merge(user_id: current_user.id)
    end

end
