class AddProtectionFlagToArticle < ActiveRecord::Migration[5.0]
  def change
	add_column :articles, :protect, :boolean, :default => false
  end
end
