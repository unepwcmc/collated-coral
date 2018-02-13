namespace :import do
  desc "import CSV data into database"
  task :repopulate, [:csv_file] => [:environment] do |t, args|
    [Project, Country, OceanRegion, Donor, Ecosystem, Category].each do |model|
      puts "Destroying #{model.name.pluralize}..."
      model.destroy_all
      puts "#{model.name.pluralize} destroyed!"
    end

    puts "Repopulating database..."
    import_csv_file(args.csv_file)
    puts "Repopulation complete!"
  end
end
