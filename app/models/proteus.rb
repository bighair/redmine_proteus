class Proteus < ActiveRecord::Base
  unloadable

  belongs_to :proteus_status
  belongs_to :proteus_priority
  belongs_to :change_owner, :class_name => 'User', :foreign_key => 'change_owner_id'
  belongs_to :decision_owner, :class_name => 'User', :foreign_key => 'decision_owner_id'
  belongs_to :project

  has_and_belongs_to_many :resources, :class_name => 'User', :join_table => 'proteus_resources'
  has_and_belongs_to_many :reviewers, :class_name => 'User', :join_table => 'proteus_reviewers'

  validates_presence_of :proteus_status, :change_owner, :proteus_priority, :summary, :detail,
                        :services_affected, :servers_affected, :risks, :backout_strategy,
                        :reversion_procedure, :predicted_start_date, :predicted_start_time,
                        :predicted_finish_date, :predicted_finish_time

  before_save :set_submission_date, :set_accepted_date, :set_rejected_date, :set_success_date, :set_failure_date

  def allowed_statuses
    if proteus_status.nil?
      self.proteus_status_id = 1
    end

    statuses = proteus_status.find_allowed_statuses
    statuses << proteus_status unless statuses.empty?
  end

  def self.sortable_columns
    {"owner" => ["users.lastname", "users.firstname", "users.id"],
      "id" => "proteus.id",
      "project" => "projects.name",
      "submission_date" => "submission_date",
      "proteus_statuses.description" => "proteus_statuses.description",
      "proteus_priorities.description" => "proteus_priorities.description",
      "summary" => "summary",
      "predicted_start_date" => "predicted_start_date",
      "predicted_finish_date" => "predicted_finish_date",
      "actual_start_date" => "actual_start_date",
      "actual_finish_date" => "actual_finish_date"}
  end

  protected
  def set_submission_date
    if submission_date.nil?
      if self.changed? && self.proteus_status_id != 1
        self.submission_date = Date.today
      end
    end
  end

  def set_accepted_date
    if accepted_date.nil?
      if self.changed? && (self.proteus_status_id_change == [2, 3] || self.proteus_status_id_change == [4, 3])
        self.accepted_date = Date.today
      end
    end
  end

  def set_rejected_date
    if rejected_date.nil?
      if self.changed? && self.proteus_status_id_change == [2, 4]
        self.rejected_date = Date.today
      end
    end
  end

  def set_success_date
    if success_date.nil?
      if self.changed? && self.proteus_status_id_change == [3, 5]
        self.success_date = Date.today
      end
    end
  end

  def set_failure_date
    if failure_date.nil?
      if self.changed? && self.proteus_status_id_change == [3, 6]
        self.failure_date = Date.today
      end
    end
  end
end
