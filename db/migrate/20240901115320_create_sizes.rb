class CreateSizes < ActiveRecord::Migration[7.1]
  def change
    create_table "sizes", force: :cascade do |t|
      t.string "name"
      t.timestamps
    end
  end
end
