require "tmpdir"

module HubotFactory
  class HttpPost
    include HTTParty
    default_params :output => "json"
    format :json
  end

  class BuildHubot
    @queue = :build_hubot

    # Builds and deploys a Hubot instance to Heroku.
    #
    # Returns nothing.
    def self.perform(email, name, url, adapter, adapter_vars)
      process = adapter.downcase == "twilio" ? "web" : "app"

      Dir.chdir(Dir.mktmpdir("#{name}-"))

      Hubot.create(Settings.secrets["hubot_bin"], name)
      Hubot.procfile(name, adapter, process)
      
      unless %{campfire shell}.include?(adapter)
        Hubot.add_adapter_package(adapter)
      end

      Git.init
      Git.add
      Git.commit "Initial commit"

      Heroku.create
      Heroku.config(adapter_vars)

      Git.push

      Heroku.scale(process)
      Heroku.transfer(email, Settings.secrets["heroku_user"])

      adapter_vars.each do |v|
        v["val"] = "****" if %w{ password token }.include?(v["var"].downcase)
      end

      Email.send_notification(email, name, adapter, adapter_vars)

      if url
        json = { :email => email, :name => name, :adapter => adapter }.to_json
        HttpPost.post(url, :body => json)
      end
    end
  end
end
