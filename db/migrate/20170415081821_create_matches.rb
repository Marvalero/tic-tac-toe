class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches, id: false do |t|
      t.primary_key :uuid
      t.string :name
      t.string :board
      t.timestamps
    end
  end
end
