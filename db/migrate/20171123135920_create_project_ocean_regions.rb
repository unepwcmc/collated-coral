class CreateProjectOceanRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :project_ocean_regions do |t|
      t.belongs_to :project, index: true
      t.belongs_to :ocean_region, index: true
      t.timestamps
    end
  end
end
