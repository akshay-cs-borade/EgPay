class CreateColors < ActiveRecord::Migration[7.1]
  def change
    create_table "colors", force: :cascade do |t|
      t.string "name"
      t.timestamps
    end
  end
end
