class RemoveDonorsFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :donors
  end
end
