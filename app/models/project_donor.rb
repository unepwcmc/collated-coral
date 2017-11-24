class ProjectDonor < ApplicationRecord

  belongs_to :project
  belongs_to :donor

end
