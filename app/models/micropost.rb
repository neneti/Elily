class Micropost < ApplicationRecord
  has_many :notifications, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  belongs_to :user
  has_one_attached :illusts
  scope :recent_count, -> (count) { order(created_at: :desc).limit(count) }
  scope :recent, -> { order(id: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, length: { maximum: 120 }
  validate  :illusts_size
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

  def self.week_ranks
    from  = 1.week.ago.beginning_of_day
    to    = Time.zone.now.end_of_day
    self.find(Like.where(created_at: from...to).group(:micropost_id).order('count(micropost_id) desc').limit(5).pluck(:micropost_id))
  end

  def self.main_week_ranks
    from  = 1.week.ago.beginning_of_day
    to    = Time.zone.now.end_of_day
    self.find(Like.where(created_at: from...to).group(:micropost_id).order('count(micropost_id) desc').limit(20).pluck(:micropost_id))
  end

  def self.main_month_ranks
    from  = 1.month.ago.beginning_of_day
    to    = Time.zone.now.end_of_day
    self.find(Like.where(created_at: from...to).group(:micropost_id).order('count(micropost_id) desc').limit(20).pluck(:micropost_id))
  end

  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and micropost_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        micropost_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(micropost_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      micropost_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  private

   def illusts_size
     if illusts.attached?
       if illusts.blob.byte_size > 1.megabytes
         errors.add(:illusts, "1MB以下にしてください。")
       end
     else
       errors.add(:illusts, 'ファイルを添付してください')
     end
   end
end
