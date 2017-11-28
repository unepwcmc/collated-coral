class CreateProjectEcosystems < ActiveRecord::Migration[5.1]
  def change
    create_table :project_ecosystems do |t|
      t.belongs_to :project, index: true
      t.belongs_to :ecosystem, index: true
      t.timestamps
    end
  end
end
