class ProteusController < ApplicationController
  unloadable

  before_filter :find_project, :only => [:new, :create]
  before_filter :find_optional_project, :only => [:index]
  before_filter :find_change, :only => [:show, :edit, :update, :destroy]
  before_filter :build_new_change, :only => [:new, :create]
  before_filter :authorize, :except => [:index]

  helper :proteus
  include ProteusHelper
  helper :sort
  include SortHelper

  def index
    sort_init 'id', 'desc'
    sort_update (Proteus.sortable_columns)

    case params[:format]
      when 'csv', 'pdf'
        @limit = Setting.issues_export_limit.to_i
      when 'atom'
        @limit = Setting.feeds_limit.to_i
      when 'xml', 'json'
        @offset, @limit = api_offset_and_limit
      else
        @limit = per_page_option
    end

    @total = Proteus.count
    @proteus_pages = Paginator.new @total, @limit, params['page']
    @proteus = Proteus.all.includes(:change_owner, :proteus_status, :proteus_priority, :project).order(sort_clause).offset(@offset).limit(@limit)

    respond_to do |format|
      format.html
      format.json { render :json => @proteus }
      format.atom { render_feed(@proteus, :title => "Change Control Feed") }
      format.csv  { send_data(proteus_to_csv(@proteus), :type => 'text/csv; header=present', :filename => 'export.csv') }
      format.pdf  { send_data(issues_to_pdf(@proteus), :type => 'application/pdf', :filename => 'export.pdf') }
    end
  end

  def new
    respond_to do |format|
      format.html
      format.json { render :json => @proteus }
    end
  end

  def create
    @proteus = Proteus.new(proteus_params)
    @proteus.project_id = @project.id

    respond_to do |format|
      if @proteus.save
        format.html { redirect_to(:action => 'show', :id => @proteus, :notice => 'Change Request was successfully created.') }
        format.json { render :json => @proteus, :status => :created, :location => @proteus }
      else
        format.html { render :action => "new" }
        format.json { render :json => @proteus.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render :json => @proteus }
    end
  end

  def edit
    update_change
  end

  def update
    update_change
    params[:proteus][:resource_ids] ||= []
    params[:proteus][:reviewer_ids] ||= []

    respond_to do |format|
      if @proteus.update_attributes(proteus_params)
        format.html { redirect_to(:action => 'show', :id => @proteus, :notice => 'Change Request was successfully updated.') }
        format.json { render :json => {}, :status => ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @proteus.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @proteus.destroy

    respond_to do |format|
      format.html { redirect_back_or_default(:action => 'index', :project_id => @project) }
      format.json { render :json => {}, :status => :ok }
    end
  end

private

  def find_change
    @proteus = Proteus.find(params[:id])
    @project = @proteus.project
    @allowed_statuses = @proteus.allowed_statuses
    @priority = ProteusPriority.all
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def update_change
    @status = ProteusStatus.all
    @user = User.all
    @allowed_statuses = @proteus.allowed_statuses
    @priority = ProteusPriority.all
  end

  def build_new_change
    if params[:id].blank?
      @proteus = Proteus.new
      @proteus.project = @project
    else
      @proteus = Proteus.new(proteus_params)
    end

    @proteus.project = @project
    update_change
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def proteus_params
    params.require(:proteus).permit(:id, :submission_date, :proteus_status_id, :change_owner_id, :proteus_priority_id, :summary, :detail, :ticket_references, :services_affected, :servers_affected, :risks, :backout_strategy, :reversion_procedure, :predicted_start_date, :predicted_start_time, :predicted_finish_date, :predicted_finish_time, :decision_owner_id, :review_notes, :actual_start_date, :actual_start_time, :actual_finish_date, :actual_finish_time, :completion_notes, :created_on, :updated_on, :project_id, :accepted_date, :rejected_date, :success_date, :failure_date, resource_ids:[], reviewer_ids:[])
  end
end
