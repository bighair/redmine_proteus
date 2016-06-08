class AddWorkflows < ActiveRecord::Migration
  def self.up
    create_table :proteus_workflows do |t|
      t.integer :old_status_id
      t.integer :new_status_id
    end
    
    execute "INSERT INTO `proteus_workflows` (`old_status_id`,`new_status_id`) VALUES ('1','2')"
    execute "INSERT INTO `proteus_workflows` (`old_status_id`,`new_status_id`) VALUES ('2','3')"
    execute "INSERT INTO `proteus_workflows` (`old_status_id`,`new_status_id`) VALUES ('2','4')"
    execute "INSERT INTO `proteus_workflows` (`old_status_id`,`new_status_id`) VALUES ('3','5')"
    execute "INSERT INTO `proteus_workflows` (`old_status_id`,`new_status_id`) VALUES ('3','6')"
    execute "INSERT INTO `proteus_workflows` (`old_status_id`,`new_status_id`) VALUES ('4','2')"
  end

  def self.down
    drop_table :proteus_workflows
  end
end