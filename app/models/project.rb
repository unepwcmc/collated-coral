require 'csv'

class Project < ApplicationRecord

  has_and_belongs_to_many :countries, class_name: 'Country', join_table: 'project_countries'
  has_and_belongs_to_many :donors, class_name: 'Donor', join_table: 'project_donors'
  has_and_belongs_to_many :ecosystems, class_name: 'Ecosystem', join_table: 'project_ecosystems'
  has_and_belongs_to_many :ocean_regions, class_name: 'OceanRegion', join_table: 'project_ocean_regions'

  def self.filters_to_json
    projects = Project.all.order(id: :asc)
    unique_donors = Donor.pluck(:name).compact.sort
    unique_countries = Country.pluck(:name).compact.sort
    unique_ocean_based_regions = OceanRegion.pluck(:name).compact.sort
    unique_categories = projects.pluck(:category).compact.uniq.sort
    unique_ecosystems = Ecosystem.pluck(:name).compact.sort

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
    ].to_json
  end

  def self.projects_to_json
    projects = Project.all.order(id: :asc).to_a.map! do |project|
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
    end.to_json
  end

  def self.to_csv(ids = [])

    csv = ''

    project_columns = Project.new.attributes.keys

    project_columns.delete("created_at")
    project_columns.delete("updated_at")

    project_columns.map! { |e|
      e.gsub("_", " ").capitalize
    }

    csv << project_columns.join(',')
    csv << "\r\n"

    projects = Project.where(id: ids).order(start_date: :desc)

    projects.to_a.each do |project|
      project_attributes = project.attributes
      project_attributes.delete("created_at")
      project_attributes.delete("updated_at")
      project_attributes = project_attributes.values.map{ |e| "\"#{e}\"" }
      csv << project_attributes.join(',').to_s
      csv << "\r\n"
    end

    csv

  end

end
