require "tmpdir"

module HubotFactory
  class BuildJanky
    @queue = :build_janky

    def self.perform

      # Step 1: create temporary working directory and change into it
      # Dir.chdir(Dir.mktmpdir)

      # Step 2: git clone git://gist.github.com/1497335 janky
      # Git.clone "git://gist.github.com/1497335", "janky"

      # Step 3: cd janky
      # Dir.chdir "./janky"

      # Step 4: bundle install --path vendor/bundle
      # Bundler.install "--path vendor/bundle"

      # Step 5: git add Gemfile.lock
      # Git.add "Gemfile.lock"

      # Step 6: git commit -m 'Add Gemfile.lock for Heroku'
      # Git.commit "Add Gemfile.lock for Heroku"

      # Step 7: heroku create --stack cedar
      # Heroku.create

      # Step 8: heroku addons:add shared-database
      # Heroku.addon_add "shared-database"

      # Step 9: add config variables:
      # Heroku.config janky_vars

      # Step 10: git push heroku master
      # Git.push "heroku", "master"

      # Step 11: heroku run rake db:migrate
      # Heroku.run "rake db:migrate"

    end
  end
end
