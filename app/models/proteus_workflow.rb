class ProteusWorkflow < ActiveRecord::Base
  
  belongs_to :old_status, :class_name => 'ProteusStatus', :foreign_key => 'old_status_id'
  belongs_to :new_status, :class_name => 'ProteusStatus', :foreign_key => 'new_status_id'

end
