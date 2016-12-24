class RemoveColumns < ActiveRecord::Migration
  def change
  end

  def self.up
      remove_column :tickets , :author_id 
  end
end
