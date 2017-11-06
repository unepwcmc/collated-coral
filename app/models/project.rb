require 'csv'

class Project < ApplicationRecord

  def self.to_csv(ids = [])

    csv = ''

    project_columns = ["Number", "Project Title", "Donor(s)", "Status", "Start Date", "End Date",
                       "Country", "Ocean-based Region", "Beneficiaries", "Implementing Agency",
                       "Total Project Cost", "Co-funding entities", "Category", "Team Leader",
                       "Further Information"]

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

    File.open("collated-coral-#{Date.today}.csv", "w") { |file| file.write csv }

    csv

  end

end
