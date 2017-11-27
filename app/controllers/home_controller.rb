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
    unique_donors = Donor.pluck(:name).sort
    unique_countries = Country.pluck(:name).sort
    unique_ocean_based_regions = OceanRegion.pluck(:name).sort
    unique_categories = projects.pluck(:category).uniq.sort
    unique_ecosystems = Ecosystem.pluck(:name).sort

    projects = Project.all.to_a.map! do |project|
      {
        id: project.id,
        project_title: project.project_title,
        donors: project.donors.pluck(:name).sort,
        status: project.status,
        start_date: project.start_date,
        end_date: project.end_date,
        country: project.countries.pluck(:name).sort,
        ecosystem: project.ecosystems.pluck(:name).sort,
        ocean_based_region: project.ocean_regions.pluck(:name).sort,
        beneficiaries: project.beneficiaries,
        implementing_agency: project.implementing_agency,
        total_project_cost: project.total_project_cost,
        co_funding_entities: project.co_funding_entities,
        category: project.category,
        team_leader: project.team_leader,
        further_information: project.further_information
      }
    end

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
        options: unique_donors,
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
        options: unique_categories
      },
      {
        name: "ecosystem",
        title: "Ecosystem",
        options: unique_ecosystems,
        type: 'multiple'
      },
      {
        name: "country",
        title: "Country",
        options: unique_countries,
        type: 'multiple'
      },
      {
        name: "ocean_based_region",
        title: "Ocean Region",
        options: unique_ocean_based_regions,
        type: 'multiple'
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
