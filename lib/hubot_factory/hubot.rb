module HubotFactory
  module Hubot
    # Create a new Hubot with the specified name.
    #
    # Returns nothing.
    def self.create(hubot_bin,  name)
      system "#{hubot_bin} -c . -n #{name}"
    end

    # Configure the Procfile with the specified name, adapter and process type.
    #
    # Returns nothing.
    def self.procfile(name, adapter, process)
      system "sed", "-i", "s/-n Hubot/-n #{name}/", "Procfile"
      system "sed", "-i", "s/-a campfire/-a #{adapter}/", "Procfile"
      system "sed", "-i", "s/app:/#{process}:/", "Procfile"
    end

    # Add the required adapter package as a dependency into `package.json`.
    #
    # Returns nothing.
    def self.add_adapter_package(adapter)
      pkg  = JSON.parse(File.read("package.json"))
      pkg["dependencies"]["hubot-#{adapter}"] = ">= 0.0.1"

      File.open("package.json", "w") do |f|
        f.write(JSON.pretty_generate(pkg))
      end
    end
  end
end
