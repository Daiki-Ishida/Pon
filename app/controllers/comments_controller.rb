class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.user_id = 1
    comment.post_id = 1
    comment.save
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = "編集完了しました"
      redirect_to post_path(@comment.post)
    else
     render 'edit'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    post = Post.find(comment.post_id)
    comment.destroy
    redirect_to post_path(post)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end
