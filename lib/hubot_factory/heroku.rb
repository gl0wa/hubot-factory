module HubotFactory
  module Heroku
    # Add an addon to the Heroku application.
    #
    # Returns nothing.
    def self.addon_add(addon)
      system "heroku addons:add #{addon}"
    end

    # Set the Heroku config variables.
    #
    # Returns nothing.
    def self.config(app_url, variables)
      puts variables.inspect
      vars = variables.map { |v| "#{v["var"]}=\"#{v["val"]}\"" }
      system "heroku config:add #{vars.join(" ")}"
      system "heroku config:add HEROKU_URL=#{app_url}"
    end

    # Create a new Heroku application on the cedar stack.
    #
    # Returns a String of the Heroku application URL.
    def self.create
      output = `heroku create --stack cedar`
      puts output
      output[/\A.+?\n(.+?)\s\|/, 1]
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
      process = "web" unless process
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
