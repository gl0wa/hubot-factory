module HubotFactory
  module Email
    # Send a rendered email notification to the user that their hubot has been
    # built and deployed to Heroku.
    #
    # Returns nothing.
    def self.send_hubot_email(email, name, adapter, adapter_vars)
      body = render_email("hubot", :name         => name,
                                   :adapter      => adapter,
                                   :adapter_vars => adapter_vars)

      send_email(email, "Your Hubot is Ready", body)
    end

    # Send a rendered email notification to the user that their Janky has been
    # deployed to Heroku.
    #
    # Returns nothing.
    def self.send_janky_email(email, config_vars)
      body = render_email("janky", :config_vars => config_vars)
      send_email(email, "Your Janky is Ready", body)
    end

    # Render the mustache template of the email body.
    #
    # Returns nothing.
    def self.render_email(template, args)
      path = File.expand_path("../templates/email_#{template}.mustache",
                              __FILE__)
      tmpl = IO.read(path)
      body = Mustache.render(tmpl, args)
    end

    # Send the rendered email to the user.
    #
    # Returns nothing.
    def self.send_email(email, subject, body)
      Pony.mail(:to      => email,
                :from    => Settings.secrets["email_from"],
                :subject => subject,
                :body    => body,
                :headers => { "Content-Type" => "text/html" });
    end
  end
end
