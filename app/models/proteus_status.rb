class ProteusStatus < ActiveRecord::Base

  has_many :proteus
  has_many :proteus_workflows, :foreign_key => "old_status_id"

  def find_allowed_statuses

       proteus_workflows.all.includes(:new_status).collect{|w| w.new_status}

  end

end
