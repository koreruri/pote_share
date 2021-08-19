class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :person_num, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
