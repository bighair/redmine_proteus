require_dependency 'user'

# Patches Redmine's Users dynamically.
module UserProteusPatch
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      has_many :changings, :class_name => 'Proteus', :foreign_key => 'change_owner_id', :dependent => :delete_all
      has_many :decisions, :class_name => 'Proteus', :foreign_key => 'decision_owner_id', :dependent => :delete_all
      has_and_belongs_to_many :required_resources, :class_name => 'Proteus', :join_table => 'proteus_resources'
      has_and_belongs_to_many :review_resources, :class_name => 'Proteus', :join_table => 'proteus_reviewers'
    end

  end

  module ClassMethods

  end

  module InstanceMethods
    
  end
end

# Add module to Project
User.send(:include, UserProteusPatch)

