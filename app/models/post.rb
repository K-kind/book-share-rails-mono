class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  has_one_attached :image

  validates :content, presence: true, length: { maximum: 255 }
  validates :rate, numericality: { in: 1..5 }

  RATES = [1, 2, 3, 4, 5]

  def likes_count
    likes.size
  end

  def is_liked_by?(user)
    likes.any? { |like| like.user_id == user.id }
  end
end
