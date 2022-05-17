class ChangeUserIdToBeReference < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :user_id, :integer, references: :users
  end
end
