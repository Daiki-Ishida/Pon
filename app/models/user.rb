class User < ApplicationRecord
  has_many :ferrets, dependent: :destroy
end
