class RenameColumnInPosts < ActiveRecord::Migration[7.1]
  def change
    rename_column :posts, :author_id_id, :author_id
  end
end
