class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :content, presence: true, length: { maximum: 255 }
  validates :rate, numericality: { in: 1..5 }

  RATES = [1, 2, 3, 4, 5]
end
