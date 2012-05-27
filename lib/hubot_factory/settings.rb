module HubotFactory
  class Settings

    # TODO: Maybe we can get this from the system somehow?
    def self.heroku_user
      ENV["HUBOT_FACTORY_HEROKU_USER"]
    end

    # TODO: Make all of these go away by using Heroku services wherever possible.
    def self.email_host
      ENV["HUBOT_FACTORY_EMAIL_HOST"]
    end

    def self.email_port
      ENV["HUBOT_FACTORY_EMAIL_PORT"]
    end

    def self.email_user
      ENV["HUBOT_FACTORY_EMAIL_USER"]
    end

    def self.email_pass
      ENV["HUBOT_FACTORY_EMAIL_PASS"]
    end

    def self.email_name
      ENV["HUBOT_FACTORY_EMAIL_FROM"]
    end

    def self.email_domain
      ENV["HUBOT_FACTORY_EMAIL_DOMAIN"]
    end

    # TODO: hubot_bin will go away once it is split into a separate app.
    def self.hubot_bin
      ENV["HUBOT_FACTORY_HUBOT_BIN"]
    end

    # TODO: Replace resque with Qu and then we don't need a web interface :)
    def self.redis_host
      ENV["HUBOT_FACTORY_REDIS_HOST"]
    end

    def self.redis_port
      ENV["HUBOT_FACTORY_REDIS_PORT"]
    end

    def self.redis_pass
      ENV["HUBOT_FACTORY_REDIS_PASS"]
    end

    def self.resque_web_user
      ENV["HUBOT_FACTORY_RESQUE_USER"]
    end

    def self.resque_web_pass
      ENV["HUBOT_FACTORY_RESQUE_PASS"]
    end
  end
end
