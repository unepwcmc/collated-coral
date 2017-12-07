class RemoveTeamLeaderFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :team_leader
  end
end
