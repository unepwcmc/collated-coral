class RemoveOceanBasedRegionFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :ocean_based_region
  end
end
