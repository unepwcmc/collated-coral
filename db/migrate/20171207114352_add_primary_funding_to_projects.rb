class AddPrimaryFundingToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :primary_funding, :string
  end
end
