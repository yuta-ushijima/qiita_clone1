class ChangeColumnToArticle < ActiveRecord::Migration[5.2]
  def up
    change_column :articles, :status, :integer, null: false, default: 0, limit: 1
  end

  def down
    change_column :articles, :status, :integer
  end
end
