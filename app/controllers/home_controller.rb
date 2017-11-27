class HomeController < ApplicationController
  def index

    @filters = Project.filters_to_json
    @projects = Project.projects_to_json

  end

  def download
    send_data Project.to_csv(params[:ids]&.split(",")), {
              type: "text/csv; charset=iso-8859-1; header=present",
              disposition: "attachment",
              filename: "collated-coral-#{Date.today}.csv" }
  end

end
