class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.user_id = 1
    comment.post_id = 1
    comment.save
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end
