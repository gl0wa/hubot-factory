module HubotFactory
  module Heroku
    # Add an addon to the Heroku application.
    #
    # Returns nothing.
    def self.addon_add(addon)
      system "heroku addon:add #{addon}"
    end

    # Set the Heroku config variables.
    #
    # Returns nothing.
    def self.config(variables)
      vars = variables.map { |v| "#{v["var"]}=\"#{v["val"]}\"" }
      system "heroku config:add #{vars.join(" ")}"
    end

    # Create a new Heroku application on the cedar stack.
    #
    # Returns nothing.
    def self.create
      system "heroku create --stack cedar"
    end

    # Run the command on the Heroku application.
    #
    # Returns nothing.
    def self.run(command)
      system "heroku run #{command}"
    end

    # Scale the specified process type to 1.
    #
    # Returns nothing.
    def self.scale(process=nil)
      process = "app" unless process
      system "heroku ps:scale #{process}=1"
    end

    # Transfer the Heroku application to the user and remove self as a
    # collaborator.
    #
    # Returns nothing.
    def self.transfer(to, from)
      system "heroku sharing:add #{to}"
      system "heroku sharing:transfer #{to}"
      system "heroku sharing:remove #{from}"
    end
  end
end
