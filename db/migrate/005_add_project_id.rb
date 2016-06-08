class AddProjectId < ActiveRecord::Migration
  def self.up
    change_table :proteus do |t|
      t.references :project, :null => false, :default => "0"
    end
  end

  def self.down
    change_table :proteus do |t|
      t.remove :project
    end
  end
end