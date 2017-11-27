class Donor < ApplicationRecord

  has_many :project_donors
  has_many :projects, through: :project_donors

end
