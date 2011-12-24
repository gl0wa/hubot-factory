require "tmpdir"

module HubotFactory
  class BuildJanky
    @queue = :build_janky

    # Builds and deploys a Janky instance to Heroku.
    #
    # Returns nothing.
    def self.perform(email, janky_vars)

      tmp_dir = Dir.mktmpdir

      Dir.chdir(tmp_dir)

      Git.clone "git://gist.github.com/1497335", tmp_dir

      Bundler.clean_system "cd #{tmp_dir} && bundle install --path vendor/bundle"

      Git.add "Gemfile.lock"

      Git.commit "Add Gemfile.lock for Heroku"

      app_url = Heroku.create

      Heroku.addon_add "shared-database"

      janky_vars << { "var" => "JANKY_CONFIG_DIR", "val" => "/app/config" }
      janky_vars << { "var" => "JANKY_BASE_URL", "val" => app_url }

      puts janky_vars.inspect
      
      Heroku.config janky_vars

      Git.push "heroku", "master"

      Heroku.run "rake db:migrate"
      
      Heroku.scale

      Heroku.transfer(email, Settings.secrets["heroku_user"])

      janky_vars.each do |v|
        v["val"] = "****" if v["var"] =~ /(password|token)/i
      end

      Email.send_janky_email(email, janky_vars)
    end
  end
end
