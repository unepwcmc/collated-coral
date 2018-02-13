class AmendProjectTitleColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :projects, :project_title, :title
  end
end
