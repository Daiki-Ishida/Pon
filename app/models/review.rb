class Review < ApplicationRecord
  belongs_to :contract

  validates :rate, presence: true, numericality: {less_than_or_equal_to: 5}

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
        content =  "#{contract.owner.name}さんからレビューが届きました!
                    コメント： #{self.comment}"
      end
      return content
    end
end
