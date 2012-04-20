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
      process = "web"

      Dir.chdir(Dir.mktmpdir("#{name}-"))

      Hubot.create(Settings.secrets["hubot_bin"], name)
      
      Hubot.procfile(name, adapter, process)
      
      unless %{campfire shell}.include?(adapter)
        Hubot.add_adapter_package(adapter)
      end

      Git.init
      
      Git.add
      
      Git.commit "Initial commit"

      app_url = Heroku.create

      Heroku.config(app_url, adapter_vars)

      Git.push "heroku", "master"

      Heroku.scale(process)

      Heroku.transfer(email, Settings.secrets["heroku_user"])

      adapter_vars.each do |v|
        v["val"] = "****" if v["var"] =~ /(password|token)/i
      end

      Email.send_hubot_email(email, name, adapter, adapter_vars)

      if url
        json = { :email => email, :name => name, :adapter => adapter }.to_json
        HttpPost.post(url, :body => json)
      end
    end
  end
end
