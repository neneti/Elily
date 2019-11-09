# frozen_string_literal: true

class RemovePictureFromMicroposts < ActiveRecord::Migration[5.2]
  def change
    remove_column :microposts, :picture, :string
  end
end
