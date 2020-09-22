class AddHashWordToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :hash_word, :string
  end
end
