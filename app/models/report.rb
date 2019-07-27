class Report < ApplicationRecord
  belongs_to :contract

  has_one_attached :image

  validates :content, presence: true

# 要リファクタリング
  def send_notice(sender, type, url)
    contract = self.contract
    content = self.create_content(type, url)
    room = Room.find_room(contract.owner_id, contract.sitter_id)
    Message.create!(
      sender_id: sender.id,
      room_id: room.id,
      content: content
    )
  end

  def create_content(type, url)
    contract = self.contract
    case type
    when "create"
      content =  "#{contract.sitter.name}さんが#{self.date}日のレポートを作成しました!
                  #{contract.owner.name}さんは次のリンクからご確認をお願いします！
                  #{url}"
    when "update"
      content = "#{contract.sitter.name}さんがレポートを編集しました!
                 #{contract.owner.name}さんは次のリンクからご確認をお願いします！
                 #{url}"
    end
    return content
  end
end
