class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)

    if @comment.save(comment_params)
    	flash[:success] = "The comment was created successfully."
    	redirect_to post_path(@post)
    else
    	flash.now[:error] = "Cannot create this comment."
    	redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    if @comment.destroy
	    flash[:success] = "The comment was destroyed successfully."
	    redirect_to post_path(@post)
    end
    
  end
 
  private
    def comment_params
      params.require(:comment).permit(:description).merge(user_id: current_user.id)
    end

end
