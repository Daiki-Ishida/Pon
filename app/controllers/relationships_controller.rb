class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    follow = Relationship.new(follow_params)
    follow.save!
    user = User.find(follow.followed_id)
    render partial: "components/unfollow-btn/unfollow-btn", locals: {user: user}
  end

  def destroy
    follow = current_user.active_relationships.find_by(followed_id: params[:relationship][:followed_id])
    follow.destroy!
    user = User.find(params[:relationship][:followed_id])
    render partial: "components/follow-btn/follow-btn", locals: {user: user}
  end

  private
    def follow_params
        params.require(:relationship).permit(:followed_id).merge(follower_id: current_user.id)
    end
end
