class Micropost < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  belongs_to :user
  has_one_attached :illusts
  default_scope -> { order(created_at: :desc) }
  scope :recent, -> (count) { order(start_time: :desc).limit(count) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :illusts_size
  scope :recent, -> { order(start_time: :desc).limit(3) }
  acts_as_taggable
  def like(user)
    likes.create(user_id: user.id)
  end

  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  def like?(user)
    liked_users.include?(user)
  end

  private

   def illusts_size
     if illusts.blob.byte_size > 1.megabytes
       errors.add(:illusts, "5MB以下にしてください。")
     end
   end
end
