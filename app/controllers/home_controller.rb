class HomeController < ApplicationController
  def index

    projects = Project.all.order(start_date: :desc)
    unique_donors = projects.pluck(:donors).uniq.sort
    unique_start_date = projects.pluck(:start_date).uniq.sort.reverse
    unique_end_date = projects.pluck(:end_date).uniq.sort.reverse
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
        name: "donor",
        title: "Donor(s)",
        options: unique_donors
      },
      {
        name: "status",
        title: "Status",
        options: [ "Active", "Closed" ]
      },
      {
        name: "start_date",
        title: "Start Date",
        options: unique_start_date
      },
      {
        name: "end_date",
        title: "End Date",
        options: unique_end_date
      },
      {
        name: "country",
        title: "Country",
        options: unique_country
      },
      {
        name: "ocean_based_region",
        title: "Ocean Based Region",
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
