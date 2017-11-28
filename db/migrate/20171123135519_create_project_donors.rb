class CreateProjectDonors < ActiveRecord::Migration[5.1]
  def change
    create_table :project_donors do |t|
      t.belongs_to :project, index: true
      t.belongs_to :donor, index: true
      t.timestamps
    end
  end
end
