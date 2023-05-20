class AddColumnToBike < ActiveRecord::Migration[7.0]
  enable_extension 'hstore' unless extension_enabled?('hstore') 
  def change
    add_column :bikes, :color, :string, array: true, default: [] # add color column as array
    add_column :bikes, :images, :hstore # add images column as array
  end
end
