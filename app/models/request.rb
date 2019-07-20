class Request < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  belongs_to :sitter, class_name: "User", foreign_key: "sitter_id"

  validates :owner_id, presence: true
  validates :sitter_id, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :fee, presence: true
  validates :memo, presence: true


  def send_notice(sender, type, url)
    content = self.create_content(type, url)
    room = Room.find_room(self.owner_id, self.sitter_id)
    Message.create!(
      sender_id: sender.id,
      room_id: room.id,
      content: content
    )
  end

  def create_content(type, url)
    case type
    when "create"
      content =  "#{self.owner.name}さんが正式依頼を出しました!
                  #{self.sitter.name}さんは次のリンクからご確認をお願いします！
                  #{url}"
    when "update"
      content = "#{self.owner.name}さんが依頼を編集しました!
                 #{self.sitter.name}さんは次のリンクからご確認をお願いします！
                 #{url}"
    when "withdraw"
      content = "#{self.owner.name}さんが依頼を取り下げました。"
    when "approved"
      content = "#{self.sitter.name}さんにより依頼が承認されました！
                 依頼内容は以下のリンクから確認できます。
                 #{url}"
    end
    return content
  end

end
