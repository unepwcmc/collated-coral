class CreateProjectCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :project_countries do |t|
      t.belongs_to :project, index: true
      t.belongs_to :country, index: true
      t.timestamps
    end
  end
end
