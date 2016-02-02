class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, index: true, foreign_key: true
      t.references :micropost, index: true, foreign_key: true

      t.timestamps null: false
      
      # 複合インデックス
      t.index [:user_id, :micropost_id], unique: true
    end
  end
end
