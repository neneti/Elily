class Micropost < ApplicationRecord
  belongs_to :user
  has_many_attached :illusts
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :illusts_size

  private


   def illusts_size
     if illusts.size > 1.megabytes
       errors.add(:illusts, "5MB以下にしてください。")
     end
   end
end
