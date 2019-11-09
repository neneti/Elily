# frozen_string_literal: true

class AddLikesCountToMicroposts < ActiveRecord::Migration[5.2]
  def change
    unless column_exists? :microposts, :likes_count
      add_column :microposts, :likes_count, :integer, null: false, default: 0
    end
  end
end
