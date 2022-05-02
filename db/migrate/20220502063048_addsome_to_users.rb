class AddsomeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :introduce, :text
    add_column :users, :deleted_flag, :boolean, default: false
    add_column :users, :image_name, :string
  end
end
