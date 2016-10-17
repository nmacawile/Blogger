class SetArticleHitsDefaultToZero < ActiveRecord::Migration[5.0]
  def change
	change_column :articles, :hits, :integer, :default => 0
  end
end
