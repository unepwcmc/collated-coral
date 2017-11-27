class RemoveCountryFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :country
  end
end
