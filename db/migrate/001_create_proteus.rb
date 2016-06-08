class CreateProteus < ActiveRecord::Migration
  def self.up
    create_table :proteus_statuses do |t|
      t.string :description
    end

    create_table :proteus_priorities do |t|
      t.string :description
    end

    create_table :proteus do |t|
      t.date :submission_date
      t.integer :proteus_status_id, :null => false
      t.integer :change_owner_id, :null => false
      t.integer :proteus_priority_id, :null => false
      t.string :summary, :null => false
      t.text :detail, :null => false
      t.text :ticket_references
      t.string :services_affected, :null => false
      t.text :servers_affected
      t.string :risks, :null => false
      t.text :backout_strategy, :null => false
      t.text :reversion_procedure, :null => false
      t.date :predicted_start_date, :null => false
      t.time :predicted_start_time, :null => false
      t.date :predicted_finish_date, :null => false
      t.time :predicted_finish_time, :null => false
      t.date :decision_date
      t.integer :decision_owner_id
      t.string :review_team_ids
      t.text :review_notes
      t.date :actual_start_date
      t.time :actual_start_time
      t.date :actual_finish_date
      t.time :actual_finish_time
      t.text :completion_notes
    end
  end

  def self.down
    drop_table :proteus
    drop_table :proteus_priorities
    drop_table :proteus_statuses
  end
end
