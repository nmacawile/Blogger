class AddHitsCounterToArticle < ActiveRecord::Migration[5.0]
  def change
	add_column :articles, :hits,    :integer
  end
end
