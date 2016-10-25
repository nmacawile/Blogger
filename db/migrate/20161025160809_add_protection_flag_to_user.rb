class AddProtectionFlagToUser < ActiveRecord::Migration[5.0]
  def change
	add_column :authors, :protect, :boolean, :default => false
  end
end
