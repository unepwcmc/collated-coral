require 'csv'

namespace :import do
  desc "import CSV data into database"
  task :projects, [:csv_file] => [:environment] do |t, args|

    import_csv_file(args.csv_file)

  end

  def import_csv_file file

    fields = ["donors", "countries", "ecosystems", "ocean_regions"]

    fields.each do |field|
      define_method("import_#{field.downcase}".to_sym) do |project, list_of_children|
        list_of_children = list_of_children.split(",")
        list_of_children.each do |child_name|
          field.camelize.singularize.constantize.find_or_create_by(name: child_name) do |new_child|
            project.send(field.downcase.to_sym) << new_child
          end
        end
      end
    end

    csv = File.open(file)

    csv_headers = File.readlines(csv).first.split(",")

    project_hash = {
      id: csv_headers[0],
      project_title: csv_headers[1],
      donors: csv_headers[2],
      status: csv_headers[3],
      start_date: csv_headers[4],
      end_date: csv_headers[5],
      country: csv_headers[6],
      ocean_region: csv_headers[7],
      beneficiaries: csv_headers[8],
      implementing_agency: csv_headers[9],
      total_project_cost: csv_headers[10],
      co_funding_entities: csv_headers[11],
      category: csv_headers[12],
      team_leader: csv_headers[13],
      ecosystems: csv_headers[14],
      further_information: csv_headers[15]
    }

    CSV.parse(csv, :headers => true) do |row|
      project_row = row.to_hash
      current_project_id = project_row[project_hash[:id]]&.strip.to_i

      if Project.exists?(id: current_project_id)
        project = Project.find_by_id(current_project_id)
      else
        project = Project.new
        project.id = current_project_id
      end

      project.project_title = project_row[project_hash[:project_title]]&.strip
      import_donors(project, project_row[project_hash[:donors]]&.strip)
      project.status = project_row[project_hash[:status]]&.strip || "Empty"
      project.start_date = project_row[project_hash[:start_date]]&.strip || DateTime.now.year.to_i
      project.end_date = project_row[project_hash[:end_date]]&.strip || DateTime.now.year.to_i
      import_countries(project, project_row[project_hash[:country]]&.strip)
      import_ecosystems(project, project_row[project_hash[:ecosystems]]&.strip)
      import_ocean_regions(project, project_row[project_hash[:ocean_region]]&.strip)
      project.beneficiaries = project_row[project_hash[:beneficiaries]]&.strip
      project.implementing_agency = project_row[project_hash[:implementing_agency]]&.strip
      project.total_project_cost = project_row[project_hash[:total_project_cost]]&.strip
      project.co_funding_entities = project_row[project_hash[:co_funding_entities]]&.strip
      project.category = project_row[project_hash[:category]]&.strip
      project.team_leader = project_row[project_hash[:team_leader]]&.strip
      project.further_information = project_row[project_hash[:further_information]]&.strip

      unless project.save!
        Rails.logger.info "Cannot import! #{project.project_title}"
      end

    end

    csv.close

    Rails.logger.info "Imported projects, total records: #{Project.count}"

  end

end
