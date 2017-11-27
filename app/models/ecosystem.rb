class Ecosystem < ApplicationRecord

  has_many :project_ecosystems
  has_many :projects, through: :project_ecosystems

end
