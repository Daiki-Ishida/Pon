class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_commented?, except: [:create]

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    if comment.save
      comment.post.create_notification(current_user, "comment")
      render partial: "components/comment/comment", locals: {comment: comment}
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:info] = "コメントの内容を編集しました。"
      redirect_to post_path(@comment.post)
    else
      flash[:warning] = "入力内容に誤りがあります。"
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
      params.require(:comment).permit(:content, :post_id)
    end

    def correct_commented?
      comment = Comment.find(params[:id])
      unless current_user == comment.user
        flash[:danger] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end
