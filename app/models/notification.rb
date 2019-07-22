class Notification < ApplicationRecord
  belongs_to :action_user, class_name: "User"
  belongs_to :notified_user, class_name: "User"
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  belongs_to :message, optional: true
end
