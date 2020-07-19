class CreateSnippets < ActiveRecord::Migration[5.1]
  def change
    create_table :snippets do |t|
      t.string :title
      t.text :common
      t.text :beginner
      t.text :expert
      t.integer :user_id
      t.integer :snippet_id
      
      t.timestamps
    end
  end
end
