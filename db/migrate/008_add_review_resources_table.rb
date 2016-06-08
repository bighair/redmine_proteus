class AddReviewResourcesTable < ActiveRecord::Migration
  def self.up
    create_table :proteus_reviewers, :id => false do |t|
      t.references :proteus
      t.references :user
    end
  end

  def self.down
    drop_table :proteus_reviewers
  end
end