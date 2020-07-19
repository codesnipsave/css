class CreateSnippetTags < ActiveRecord::Migration[5.1]
  def change
    create_table :snippet_tags do |t|
      t.references :tag, foreign_key: true
      t.references :tag.version, foreign_key: true
      t.references :snippet, foreign_key: true

      t.timestamps
    end
  end
end
