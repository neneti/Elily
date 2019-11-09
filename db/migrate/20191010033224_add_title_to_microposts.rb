# frozen_string_literal: true

class AddTitleToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :title, :string
    add_column :microposts, :start_time, :datetime
  end
end
