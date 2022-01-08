class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 255 }
  validates :rate, numericality: { in: 1..5 }
end
