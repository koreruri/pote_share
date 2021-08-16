class Room < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :address, presence: true
end
