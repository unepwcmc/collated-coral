class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.text :project_title
      t.string :donors, null: false
      t.string :status, null: false
      t.integer :start_date, null: false
      t.integer :end_date, null: false
      t.string :country, null: false
      t.string :ocean_based_region, null: false
      t.string :beneficiaries
      t.string :implementing_agency
      t.string :total_project_cost
      t.string :co_funding_entities
      t.string :category
      t.string :team_leader
      t.text :further_information

      t.timestamps
    end
  end
end
