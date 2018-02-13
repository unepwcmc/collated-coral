require 'csv'

namespace :import do
  desc "import CSV data into database"
  task :projects, [:csv_file] => [:environment] do |t, args|
    import_csv_file(args.csv_file)
  end

  def import_csv_file file

    csv = File.open(file)

    csv_headers = File.readlines(csv).first.split(",")

    project_hash = {
      id: csv_headers[0],
      title: csv_headers[1],
      donors: csv_headers[2],
      categories: csv_headers[3],
      status: csv_headers[4],
      start_date: csv_headers[5],
      end_date: csv_headers[6],
      countries: csv_headers[7],
      ocean_regions: csv_headers[8],
      beneficiaries: csv_headers[9],
      implementing_agency: csv_headers[10],
      total_project_cost: csv_headers[11],
      primary_funding: csv_headers[12],
      co_funding_entities: csv_headers[13],
      ecosystems: csv_headers[14],
      weblink: csv_headers[15],
      further_information: csv_headers[16]
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

      fields = ["donors", "countries", "ecosystems", "ocean_regions", "categories"]

      fields.each do |field|
        list_of_children = project_row[project_hash[field.to_sym]]&.strip
        next if list_of_children.nil?
        list_of_children = list_of_children.split(";")
        list_of_children.each do |child_name|
          child_name = child_name&.strip
          new_child = field.camelize.singularize.constantize.find_or_create_by(name: child_name)
          unless project.send(field.downcase.to_sym).exists?(new_child.id)
            project.send(field.downcase.to_sym) << new_child
          end
        end
      end


      dates_columns = ['start_date', 'end_date', 'created_at', 'updated_at']
      (Project.column_names - dates_columns).each do |attribute|
        project.send("#{attribute}=", project_row[project_hash[attribute.to_sym]]&.strip || "Data not available")
      end
      project.title&.gsub!("\u00A0", " ")
      project.start_date = project_row[project_hash[:start_date]]&.strip || DateTime.now.year.to_i
      project.end_date = project_row[project_hash[:end_date]]&.strip || DateTime.now.year.to_i

      unless project.save!
        Rails.logger.info "Cannot import! #{project.title}"
      end

    end

    csv.close

    Rails.logger.info "Imported projects, total records: #{Project.count}"

  end

end
