class HomeController < ApplicationController
  def index

    projects = Project.all.order(id: :asc)
    unique_donors = projects.pluck(:donors).uniq.sort
    #unique_category = projects.pluck(:category).uniq.sort
    #unique_ecosystem = projects.pluck(:ecosystem).uniq.sort
    unique_country = projects.pluck(:country).uniq.sort
    unique_ocean_based_region = projects.pluck(:ocean_based_region).uniq.sort

    filters = [
      {
        title:"ID"
      },
      {
        title: "Project Title"
      },
      {
        name: "donors",
        title: "Donor(s)",
        options: unique_donors
      },
      {
        name: "status",
        title: "Status",
        options: [ "Active", "Closed" ]
      },
      {
        name: "category",
        title: "Category",
        options: ["No data yet"]
      },
      {
        name: "ecosystem",
        title: "Ecosystem",
        options: ["No data yet"]
      },
      {
        name: "country",
        title: "Country",
        options: unique_country
      },
      {
        name: "ocean_based_region",
        title: "Ocean Region",
        options: unique_ocean_based_region
      },
      {
        title: "Total Project Cost"
      }
    ]

    @filters = filters.to_json
    @projects = projects.to_json

  end

  def download
    send_data Project.to_csv(params[:ids]&.split(",")), {
              type: "text/csv; charset=iso-8859-1; header=present",
              disposition: "attachment",
              filename: "collated-coral-#{Date.today}.csv" }
  end

end
