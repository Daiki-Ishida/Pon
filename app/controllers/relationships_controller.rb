class RelationshipsController < ApplicationController
  def create
    follow = Relationship.new(follow_params)
    follow.save!
    redirect_to user_path(follow.followed_id)
  end

  def destroy
    # Relationship.find_by(follower_id: current_user.id).destroy
    # redirect_to users_path
  end

  private

    def follow_params
        params.permit(:followed_id).merge(follower_id: current_user.id)
    end
end
