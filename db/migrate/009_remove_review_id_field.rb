class RemoveReviewIdField < ActiveRecord::Migration
  def self.up
    change_table :proteus do |t|
      t.remove :review_team_ids
    end
  end

  def self.down
    change_table :proteus do |t|
      t.string :review_team_ids
    end
  end
end