class AddWeblinkToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :weblink, :string, default: ''
  end
end
