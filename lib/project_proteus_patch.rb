require_dependency 'project'

# Patches Redmine's Projects dynamically.
module ProjectProteusPatch
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      has_many :proteus, :dependent => :destroy
    end

  end

  module ClassMethods

  end

  module InstanceMethods
    
  end
end

# Add module to Project
Project.send(:include, ProjectProteusPatch)

