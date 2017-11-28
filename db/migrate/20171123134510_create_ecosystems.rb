class CreateEcosystems < ActiveRecord::Migration[5.1]
  def change
    create_table :ecosystems do |t|
      t.string :name
      t.timestamps
    end
  end
end
