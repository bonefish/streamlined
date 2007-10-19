module MultiRails

  # Simple config object
  class Config
    @default_rails_version = "1.2.5"
    @weird_versions = { "2.0.0.PR" => "1.2.4.7794" }
    @rails_requires = %w[active_record 
                         action_controller 
                         action_controller/test_process 
                         active_support]
    
    class << self
      attr_accessor :default_rails_version, :weird_versions, :rails_requires
      def version_lookup(version = nil)
        return named_version_lookup(version) if version
        return named_version_lookup(ENV["RAILS_VERSION"]) if ENV['RAILS_VERSION']
        default_rails_version
      end
      
      def named_version_lookup(pretty_version)
        version = @weird_versions[pretty_version] || pretty_version
        raise MultiRailsError if !Loader.all_rails_versions.include? version
        version
      end
    end
  end
  
end