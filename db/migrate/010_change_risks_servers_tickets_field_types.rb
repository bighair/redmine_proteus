class ChangeRisksServersTicketsFieldTypes < ActiveRecord::Migration
  def self.up
    change_column :proteus, :ticket_references, :string
    change_column :proteus, :servers_affected, :string, :null => false
    change_column :proteus, :risks, :text
  end

  def self.down
    change_column :proteus, :ticket_references, :text
    change_column :proteus, :servers_affected, :text
    change_column :proteus, :risks, :string, :null => false
  end
end