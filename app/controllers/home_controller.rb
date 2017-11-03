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
        name: "startDate",
        title: "Start Date",
        options: [ '2000', '2003' ]
      },
      {
        name: "endDate",
        title: "End Date",
        options: [ '2002', '2005' ]
      },
      {
        name: "country",
        title: "Country",
        options: [ "UK", "Australia"]
      },
      {
        name: "oceanBasedRegion",
        title: "Ocean Based Region",
        options: [ "Ocean 2"]
      },
      {
        title: "Total Project Cost"
      }
    ]

    projects = [
      {
        id: 0,
        projectTitle: "Project 1",
        donor: "Donor name",
        status: "Active",
        startDate: 2000,
        endDate: 2002,
        country: "UK",
        oceanBasedRegion: "Ocean",
        beneficiaries: "Beneficiary name",
        implementingAgency: "Agency name",
        totalProjectCost: "£300000",
        coFundingEntities: "Grant £300",
        category: "Category name",
        teamLeader: "Leader name",
        furtherInformation: "More info goes in this ",
      },
      {
        id: 1,
        projectTitle: "Project 2",
        donor: "Donor name 2",
        status: "Closed",
        startDate: 2003,
        endDate: 2005,
        country: "Australia",
        oceanBasedRegion: "Ocean",
        beneficiaries: "Beneficiary name 2",
        implementingAgency: "Agency name 2",
        totalProjectCost: "£100000",
        coFundingEntities: "Grant £100",
        category: "Category name 2",
        teamLeader: "Leader name 2",
        furtherInformation: "More info goes in this 2",
      },
      {
        id: 2,
        projectTitle: "Project 3",
        donor: "Donor name 3",
        status: "Closed",
        startDate: 2003,
        endDate: 2005,
        country: "UK",
        oceanBasedRegion: "Ocean 2",
        beneficiaries: "Beneficiary name 3",
        implementingAgency: "Agency name 3",
        totalProjectCost: "£111",
        coFundingEntities: "Grant £111",
        category: "Category name 3",
        teamLeader: "Leader name 3",
        furtherInformation: "More info goes in this 3",
      }
    ]

    projects = Project.all

    projectlist = projects.map do |project|
      {
        :id => project.number,
        :projectTitle => project.project_title,
        :donor => project.donors,
        :status => project.status,
        :startDate => project.start_date,
        :endDate => project.end_date,
        :country => project.country,
        :oceanBasedRegion => project.ocean_based_region,
        :beneficiaries => project.beneficiaries,
        :implementingAgency => project.implementing_agency,
        :totalProjectCost => project.total_project_cost,
        :coFundingEntities => project.co_funding_entities,
        :category => project.category,
        :teamLeader => project.team_leader,
        :furtherInformation => project.further_information
      }
    end

    @filters = filters.to_json
    @projects = projectlist.to_json
  end
end
