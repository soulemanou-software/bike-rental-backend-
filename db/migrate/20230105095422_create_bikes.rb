class CreateBikes < ActiveRecord::Migration[7.0]
  def change
    create_table :bikes do |t|
      t.string :name
      t.string :bike_type
      t.text :description
      t.string :brand
      t.decimal :daily_rate

      t.timestamps
    end
  end
end
