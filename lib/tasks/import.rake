require 'csv'

namespace :import do
  desc "import CSV data into database"
  task projects: :environment do
    CSV.foreach('lib/data/seed/collated-coral.csv', :headers => true) do |row|
      project_row = row.to_hash

      project = Project.new
      project.number = project_row["Number"].to_i
      project.project_title = project_row["Project Title"]
      project.donors = project_row["Donor (s)"] || "Empty"
      project.status = project_row["Status"] || "Empty"
      project.start_date = Date.strptime(project_row["Start Date"] || DateTime.now.year.to_s, '%Y')
      project.end_date = Date.strptime(project_row["End Date"] || DateTime.now.year.to_s, '%Y')
      project.country = project_row["Country"] || "Empty"
      project.ocean_based_region = project_row["Ocean-based Region"] || "Empty"
      project.beneficiaries = project_row["Beneficiaries "]
      project.implementing_agency = project_row["Implementing Agency"]
      project.total_project_cost = project_row["Total Project Cost"]
      project.co_funding_entities = project_row["Co-funding entities"]
      project.category = project_row["Category"]
      project.team_leader = project_row["Team Leader"]
      project.further_information = project_row["Further Information"]

      unless project.save!
        Rails.logger.info "Cannot import! #{project.project_title}"
      end

    end

  end

end
