class SplitDecisionDates < ActiveRecord::Migration
  def self.up
    change_table :proteus do |t|
      t.remove :decision_date
      t.date :accepted_date
      t.date :rejected_date
      t.date :success_date
      t.date :failure_date
    end
  end

  def self.down
    change_table :proteus do |t|
      t.date :decision_date
      t.remove :accepted_date
      t.remove :rejected_date
      t.remove :success_date
      t.remove :failure_date
    end
  end
end