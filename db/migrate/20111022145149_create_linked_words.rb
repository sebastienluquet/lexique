class CreateLinkedWords < ActiveRecord::Migration
  def change
    create_table :linked_words do |t|
      t.integer :word_id
      t.integer :linked_to_id

      t.timestamps
    end
  end
end
