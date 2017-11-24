class OceanRegion < ApplicationRecord

  has_many :project_ocean_regions
  has_many :projects, through: :project_ocean_regions

end
