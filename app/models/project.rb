require 'csv'

class Project < ApplicationRecord

  has_many :project_countries
  has_many :countries, through: :project_countries
  has_many :project_donors
  has_many :donors, through: :project_donors
  has_many :project_ecosystems
  has_many :ecosystems, through: :project_ecosystems
  has_many :project_ocean_regions
  has_many :ocean_regions, through: :project_ocean_regions

  def self.to_csv(ids = [])

    csv = ''

    project_columns = Project.new.attributes.keys

    project_columns.delete("created_at")
    project_columns.delete("updated_at")

    project_columns.map! { |e|
      e.gsub("_", " ").capitalize
    }

    csv << project_columns.join(',')
    csv << "\r\n"

    projects = Project.where(id: ids).order(start_date: :desc)

    projects.to_a.each do |project|
      project_attributes = project.attributes
      project_attributes.delete("created_at")
      project_attributes.delete("updated_at")
      project_attributes = project_attributes.values.map{ |e| "\"#{e}\"" }
      csv << project_attributes.join(',').to_s
      csv << "\r\n"
    end

    csv

  end

end
