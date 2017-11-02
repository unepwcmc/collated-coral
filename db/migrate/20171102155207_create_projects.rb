class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.integer :number
      t.text :project_title
      t.string :donors
      t.string :status
      t.date :start_date
      t.date :end_date
      t.string :country
      t.string :ocean_based_region
      t.string :beneficiaries
      t.string :implementing_agency
      t.integer :total_project_cost
      t.string :co_funding_entities
      t.string :category
      t.string :team_leader
      t.text :further_information

      t.timestamps
    end
  end
end
