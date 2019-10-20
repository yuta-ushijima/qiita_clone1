class CreateArticleLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :article_likes do |t|
      t.integer :article_id
      t.integer :user_id

      t.timestamps
    end
  end
end
