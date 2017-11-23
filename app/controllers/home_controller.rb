class HomeController < ApplicationController
  def index

    tempProjects = [
      {
        id: 0,
        project_title: "Project 1",
        donors: ["D1", "D2", "D3"],
        status: "Active",
        start_date: 2000,
        end_date: 2002,
        country: ["UK", "Australia"],
        ecosystem: ["A"],
        ocean_based_region: ["O1", "O2"],
        beneficiaries: "Beneficiary name",
        implementing_agency: "Agency name",
        total_project_cost: "£300000",
        co_funding_entities: "Grant £300",
        category: "Category name",
        team_leader: "Leader name",
        further_information: "More info goes in this ",
      },
      {
        id: 1,
        project_title: "Project 2",
        donors: ["D3"],
        status: "Closed",
        start_date: 2003,
        end_date: 2005,
        country: ["Australia"],
        ecosystem: ["A", "B"],
        ocean_based_region: ["O1", "O2", "O3"],
        beneficiaries: "Beneficiary name 2",
        implementing_agency: "Agency name 2",
        total_project_cost: "£100000",
        co_funding_entities: "Grant £100",
        category: "Category name 2",
        team_leader: "Leader name 2",
        further_information: "More info goes in this 2",
      },
      {
        id: 2,
        project_title: "Project 3",
        donors: ["D1", "D2"],
        status: "Closed",
        start_date: 2003,
        end_date: 2005,
        country: ["Australia", "India", "Norway"],
        ecosystem: ["A", "B", "C"],
        ocean_based_region: ["O1"],
        beneficiaries: "Beneficiary name 3",
        implementing_agency: "Agency name 3",
        total_project_cost: "£111",
        co_funding_entities: "Grant £111",
        category: "Category name 3",
        team_leader: "Leader name 3",
        further_information: "More info goes in this 3",
      }
    ]

    tempFilters = [
      {
        title:"ID"
      },
      {
        title: "Project Title"
      },
      {
        name: "donors",
        title: "Donor(s)",
        options: ["D1", "D2", "D3"],
        type: 'multiple'
      },
      {
        name: "status",
        title: "Status",
        options: [ "Active", "Closed" ]
      },
      {
        name: "category",
        title: "Category",
        options: ["Category name 1", "Category name 2", "Category name 3"],
      },
      {
        name: "ecosystem",
        title: "Ecosystem",
        options: ["A", "B", "C"],
        type: 'multiple'
      },
      {
        name: "country",
        title: "Country",
        options: ["Australia", "UK", "India", "Norway"],
        type: 'multiple'
      },
      {
        name: "ocean_based_region",
        title: "Ocean Region",
        options: ["O1", "O2", "O3"],
        type: 'multiple'
      },
      {
        title: "Total Project Cost"
      }
    ]

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
        options: ["No data yet"],
        type: 'multiple'
      },
      {
        name: "ecosystem",
        title: "Ecosystem",
        options: ["No data yet"],
        type: 'multiple'
      },
      {
        name: "country",
        title: "Country",
        options: unique_country,
        type: 'multiple'
      },
      {
        name: "ocean_based_region",
        title: "Ocean Region",
        options: unique_ocean_based_region,
        type: 'multiple'
      },
      {
        title: "Total Project Cost"
      }
    ]

    @filters = tempFilters.to_json
    @projects = tempProjects.to_json

  end

  def download
    send_data Project.to_csv(params[:ids]&.split(",")), {
              type: "text/csv; charset=iso-8859-1; header=present",
              disposition: "attachment",
              filename: "collated-coral-#{Date.today}.csv" }
  end

end
