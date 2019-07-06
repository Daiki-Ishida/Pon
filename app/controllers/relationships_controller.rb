class RelationshipsController < ApplicationController
  def create
    follow = Relationship.new(follow_params)
    follow.save!
    redirect_to user_path(follow.followed_id)
  end

  def destroy
    follow = current_user.active_relationships.find_by(followed_id: params[:id])
    follow.destroy
    redirect_to users_path
  end

  private

    def follow_params
        params.permit(:followed_id).merge(follower_id: current_user.id)
    end
end
