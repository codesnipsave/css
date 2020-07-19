class AddSnippetIdToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :snippet_id, :integer
  end
end
