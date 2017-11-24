class Country < ApplicationRecord

  has_many :project_countries
  has_many :projects, through: :project_countries

end
