class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false
      t.references :likable, polymorphic: true
      t.boolean :like

      t.timestamps
    end
  end
end
