class OceanRegion < ApplicationRecord
  has_and_belongs_to_many :projects, class_name: "Project", join_table: 'project_ocean_regions'

  validates :name, presence: true
  validates :name, uniqueness: true
end
