class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string "cards"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
