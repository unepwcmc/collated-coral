class Ecosystem < ApplicationRecord
  has_and_belongs_to_many :projects, class_name: "Project", join_table: 'project_ecosystems'
end
