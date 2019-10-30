class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  has_many :notifications, dependent: :destroy
  validates :content, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  scope :recent, -> { order(updated_at: :desc) }
end
