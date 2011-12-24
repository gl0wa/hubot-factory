require "tmpdir"

module HubotFactory
  class BuildJanky
    @queue = :build_janky

    def self.perform

      Dir.chdir(Dir.mktmpdir)

      Git.clone "git://gist.github.com/1497335", "janky"

      Dir.chdir "./janky"

      Bundler.install "--path vendor/bundle"

      Git.add "Gemfile.lock"

      Git.commit "Add Gemfile.lock for Heroku"

      Heroku.create

      Heroku.addon_add "shared-database"
      
      Heroku.config janky_vars

      Git.push "heroku", "master"

      Heroku.run "rake db:migrate"
      
      Heroku.scale

      janky_vars.each do |v|
        v["val"] = "****" if %w{ password token }.include?(v["var"].downcase)
      end

    end
  end
end
