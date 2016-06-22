module ProteusHelper
  unloadable
  include ApplicationHelper

  def proteus_to_csv(proteus)

    Redmine::Export::CSV.generate do |csv|
      # csv header fields
      headers = [ "#",
                  "Submission Date",
                  "Project",
                  "Status",
                  "Owner",
                  "Priority",
                  "Summary",
                  "Predicted Start",
                  "Predicted Finish"
                  ]
      csv << headers.collect {|c| c.to_s}
      # csv lines
      proteus.each do |proteu|
        fields = [proteu.id,
                  format_date(proteu.submission_date),
                  proteu.project.name,
                  proteu.proteus_status.description,
                  proteu.change_owner.name,
                  proteu.proteus_priority.description,
                  proteu.summary,
                  proteu.predicted_start_date,
                  proteu.predicted_finish_date
                  ]
        csv << fields.collect {|c| c.to_s}
      end
    end
  end

  def active_status(status)
    if status == "Successful" || status == "Failed"
      return false
    else
      return true
    end
  end
end
