require 'redmine'
require 'iconv'

require_dependency 'principal'
require_dependency 'user_proteus_patch'
require_dependency 'project_proteus_patch'

Rails.logger.info 'Starting Proteus plugin for Redmine'

Redmine::Plugin.register :redmine_proteus do
  name 'Redmine Proteus plugin'
  author 'Matt Roberts'
  description 'This plugin for Redmine provides a Request For Change (RFC) template and repository to facilitate a CAB process as detailed in the ITIL framework'
  version '0.0.1'

  project_module :proteus_module do
    permission :index_proteus, :proteus => :index
    permission :new_proteus, {:proteus => [:new, :create]}
    permission :show_proteus, :proteus => :show
    permission :edit_proteus, {:proteus => [:edit, :update]}
    permission :delete_proteus, :proteus => :destroy
  end

  menu :project_menu, :proteus, { :controller => 'proteus', :action => 'index' }, :caption => 'Change Control', :after => :activity, :param => :project_id
end
