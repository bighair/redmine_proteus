class AddStaticData < ActiveRecord::Migration
  def self.up
    execute "INSERT INTO `proteus_priorities` (`description`) VALUES ('Emergency')"
    execute "INSERT INTO `proteus_priorities` (`description`) VALUES ('High')"
    execute "INSERT INTO `proteus_priorities` (`description`) VALUES ('Normal')"
    execute "INSERT INTO `proteus_priorities` (`description`) VALUES ('Low')"
    execute "INSERT INTO `proteus_statuses` (`description`) VALUES ('Draft')"
    execute "INSERT INTO `proteus_statuses` (`description`) VALUES ('Submitted')"
    execute "INSERT INTO `proteus_statuses` (`description`) VALUES ('Accepted')"
    execute "INSERT INTO `proteus_statuses` (`description`) VALUES ('Rejected')"
    execute "INSERT INTO `proteus_statuses` (`description`) VALUES ('Successful')"
    execute "INSERT INTO `proteus_statuses` (`description`) VALUES ('Failed')"
  end

  def self.down
    execute "DELETE * FROM `proteus_priorities`"
    execute "DELETE * FROM `proteus_statuses`"
  end
end