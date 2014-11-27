class ChangeUserColumnNickName < ActiveRecord::Migration
  def change
    rename_column :users, :nickname, :nick_name
  end
end
