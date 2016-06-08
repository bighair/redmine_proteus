class AddTimestamps < ActiveRecord::Migration
  def self.up
    change_table :proteus do |t|
      t.timestamp :created_on, :updated_on
    end
  end

  def self.down
    change_table :proteus do |t|
      t.remove :created_on, :updated_on
    end
  end
end