require 'csv'

namespace :import do
  desc "import CSV data into database"
  task projects: :environment do
    csv = File.open('lib/data/seed/collated-coral.csv')

    csv_headers = File.readlines(csv).first.split(",")

    CSV.parse(csv, :headers => true) do |row|
      project_row = row.to_hash

      project = Project.new
      project.number = project_row[csv_headers[0]].to_i
      project.project_title = project_row[csv_headers[1]]
      project.donors = project_row[csv_headers[2]] || "Empty"
      project.status = project_row[csv_headers[3]] || "Empty"
      project.start_date = Date.strptime(project_row[csv_headers[4]] || DateTime.now.year.to_s, '%Y')
      project.end_date = Date.strptime(project_row[csv_headers[5]] || DateTime.now.year.to_s, '%Y')
      project.country = project_row[csv_headers[6]] || "Empty"
      project.ocean_based_region = project_row[csv_headers[7]] || "Empty"
      project.beneficiaries = project_row[csv_headers[8]]
      project.implementing_agency = project_row[csv_headers[9]]
      project.total_project_cost = project_row[csv_headers[10]]
      project.co_funding_entities = project_row[csv_headers[11]]
      project.category = project_row[csv_headers[12]]
      project.team_leader = project_row[csv_headers[13]]
      project.further_information = project_row[csv_headers[14]]

      unless project.save!
        Rails.logger.info "Cannot import! #{project.project_title}"
      end

    end

  end

end
