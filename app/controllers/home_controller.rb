class HomeController < ApplicationController
  def index
    # dummy data to build out the front end
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
        country: "America",
        oceanBasedRegion: "Ocean",
        beneficiaries: "Beneficiary name 3",
        implementingAgency: "Agency name 3",
        totalProjectCost: "£111",
        coFundingEntities: "Grant £111",
        category: "Category name 3",
        teamLeader: "Leader name 3",
        furtherInformation: "More info goes in this 3",
      }
    ]

    @projects = projects.to_json
  end
end