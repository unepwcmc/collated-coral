class CreateCategoryModelAndRelationshipWithProject < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :project_categories do |t|
      t.belongs_to :project, index: true
      t.belongs_to :category, index: true
      t.timestamps
    end

    remove_column :projects, :category, :string
  end
end
