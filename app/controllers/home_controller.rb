class HomeController < ApplicationController
  def index

    projects = Project.all.order(start_date: :desc)
    unique_donors = projects.uniq{|x| x.donors}.map{ |e| e.donors }
    unique_start_date = projects.uniq{|x| x.start_date}.map{ |e| e.start_date }
    unique_end_date = projects.uniq{|x| x.end_date}.map{ |e| e.end_date }
    unique_country = projects.uniq{|x| x.country}.map{ |e| e.country }
    unique_ocean_based_region = projects.uniq{|x| x.ocean_based_region}.map{ |e| e.ocean_based_region }

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
        name: "startDate",
        title: "Start Date",
        options: unique_start_date
      },
      {
        name: "endDate",
        title: "End Date",
        options: unique_end_date
      },
      {
        name: "country",
        title: "Country",
        options: unique_country
      },
      {
        name: "oceanBasedRegion",
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
    send_data Project.to_csv(params[:ids]), {
              :type => "text/csv; charset=iso-8859-1; header=present",
              :disposition => "attachment",
              :filename => "collated-coral-#{Date.today}.csv" }
  end

end
