module HubotFactory
  module Views
    class Janky < Layout
      def vars
        [
          {
            :name =>  "JANKY_BUILDER_DEFAULT",
            :desc =>  "The Jenkins server URL with a trailing slash"
          },
          {
            :name =>  "JANKY_HUBOT_USER",
            :desc =>  "Username used to protect the Hubot API"
          },
          {
            :name =>  "JANKY_HUBOT_PASSWORD",
            :desc =>  "Password used to protect the Hubot API"
          },
          {
            :name =>  "JANKY_GITHUB_USER",
            :desc =>  "Username of the GitHub user used to access the API, requires push & pull"
          },
          {
            :name =>  "JANKY_GITHUB_PASSWORD",
            :desc =>  "Password of the GitHub user"
          },
          {
            :name =>  "JANKY_GITHUB_HOOK_SECRET",
            :desc =>  "Secret used to sign the hook requests from GitHub"
          },
          {
            :name =>  "JANKY_CAMPFIRE_ACCOUNT",
            :desc =>  "The name of your Campfire account"
          },
          {
            :name =>  "JANKY_CAMPFIRE_TOKEN",
            :desc =>  "The API token of the user sending build notifications"
          },
          {
            :name =>  "JANKY_CAMPFIRE_DEFAULT_ROOM",
            :desc =>  "The name of the room where notifications are sent by default"
          },
        ]
      end
    end
  end
end
