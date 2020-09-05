class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
