class AddLikesCountToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :likes_count, :integer, null: false, default: 0 unless column_exists? :microposts, :likes_count
  end
end
