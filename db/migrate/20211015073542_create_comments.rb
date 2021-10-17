class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|

      t.text :content
      # userおよびprototypeを参照するための外部キーを記述. uesr_id, prototype_idカラムも作成される。
      t.references :user, null: false, foreign_key: true
      t.references :prototype, null: false, foreign_key: true
      t.timestamps
    end
  end
end
