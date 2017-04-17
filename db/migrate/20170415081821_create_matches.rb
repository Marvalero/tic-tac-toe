class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches, id: false do |t|
      t.string :uuid, index: true, unique: true
      t.string :name
      t.string :serialized_board
      t.timestamps
    end
  end
end
