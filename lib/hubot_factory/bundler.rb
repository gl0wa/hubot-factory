module HubotFactory
  module Bundler
    # Install dependencies with the specified options
    #
    # Returns nothing.
    def self.install(options=nil)
      system "bundle install #{options}"
    end
  end
end
