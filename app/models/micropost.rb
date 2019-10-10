class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  has_many_attached :illusts
  private

   # アップロードされた画像のサイズをバリデーションする
   def picture_size
     if picture.size > 5.megabytes
       errors.add(:picture, "5MB以下にしてください。")
     end
   end
end
