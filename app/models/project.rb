require 'csv'

class Project < ApplicationRecord

  has_and_belongs_to_many :countries, class_name: 'Country', join_table: 'project_countries'
  has_and_belongs_to_many :donors, class_name: 'Donor', join_table: 'project_donors'
  has_and_belongs_to_many :ecosystems, class_name: 'Ecosystem', join_table: 'project_ecosystems'
  has_and_belongs_to_many :ocean_regions, class_name: 'OceanRegion', join_table: 'project_ocean_regions'
  has_and_belongs_to_many :categories, class_name: "Category", join_table: 'project_categories'

  validates :title, uniqueness: true

  def self.filters_to_json
    projects = Project.all.order(id: :asc)
    unique_donors = Donor.pluck(:name).compact.sort
    unique_countries = Country.pluck(:name).compact.sort
    unique_ocean_based_regions = OceanRegion.pluck(:name).compact.sort
    unique_categories = Category.pluck(:name).compact.sort
    unique_ecosystems = Ecosystem.pluck(:name).compact.sort
    unique_status = projects.pluck(:status).compact.uniq.sort

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
        title: "Total Cost"
      },
      {
        title: "Co-funding"
      }

    ].to_json
  end

  def self.projects_to_json
    projects = Project.all.order(id: :asc).to_a.map! do |project|
      {
        id: project.id,
        title: project.title,
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
        primary_funding: project.primary_funding,
        co_funding_entities: project.co_funding_entities,
        category: project.categories.pluck(:name).sort,
        further_information: project.further_information,
        weblink: project.weblink
      }
    end.to_json
  end

  def self.to_csv(ids = [])

    csv = ''

    project_columns = Project.new.attributes.keys

    project_columns.delete_if { |k, v| ["created_at", "updated_at"].include? k }
    project_columns << "Donors"
    project_columns << "Country"
    project_columns << "Ecosystem"
    project_columns << "Ocean Based Region"
    project_columns << "Category"


    project_columns.map! { |e|
      e.gsub("_", " ").capitalize
    }

    csv << project_columns.join(',')
    csv << "\r\n"

    projects = Project.where(id: ids).order(id: :asc)

    projects.to_a.each do |project|
      project_attributes = project.attributes
      project_attributes.delete_if { |k, v| ["created_at", "updated_at"].include? k }
      project_attributes[:donors] = project.donors.pluck(:name).sort.join(",")
      project_attributes[:countries] = project.countries.pluck(:name).sort.join(",")
      project_attributes[:ecosystems] = project.ecosystems.pluck(:name).sort.join(",")
      project_attributes[:ocean_based_regions] = project.ocean_regions.pluck(:name).sort.join(",")
      project_attributes[:categories] = project.categories.pluck(:name).sort.join(",")

      project_attributes = project_attributes.values.map{ |e| "\"#{e}\"" }
      csv << project_attributes.join(',').to_s
      csv << "\r\n"
    end

    csv

  end

end
