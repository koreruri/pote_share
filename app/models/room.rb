class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :address, presence: true
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                        message: "jpeg,gif,pngファイルのいずれかを選択して下さい" },
                    size: { less_than: 5.megabytes,
                        message: "画像ファイルサイズは5MB以下にして下さい" }
end
