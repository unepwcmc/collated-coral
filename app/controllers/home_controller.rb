class HomeController < ApplicationController
  def index
    # dummy data to build out the front end
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
        options: [ "Donor name", "Donor name 2", "Donor name 3" ]
      },
      {
        name: "status",
        title: "Status",
        options: [ "Active", "Closed" ]
      },
      {
        name: "start_date",
        title: "Start Date",
        options: [ '2000', '2003' ]
      },
      {
        name: "end_date",
        title: "End Date",
        options: [ '2002', '2005' ]
      },
      {
        name: "country",
        title: "Country",
        options: [ "UK", "Australia"]
      },
      {
        name: "ocean_based_region",
        title: "Ocean Based Region",
        options: [ "Ocean 2"]
      },
      {
        title: "Total Project Cost"
      }
    ]

    @filters = filters.to_json
    @projects = Project.all.order(start_date: :desc).to_json

  end

  def download
    send_data Project.to_csv(params[:ids]), {
              :type => "text/csv; charset=iso-8859-1; header=present",
              :disposition => "attachment",
              :filename => "collated-coral-#{Date.today}.csv" }
  end

end
