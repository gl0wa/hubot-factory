require "httparty"
require "yajl"
require "mustache"
require "mustache/sinatra"
require "pony"
require "sinatra/base"
require "resque"

require "hubot_factory/settings"

Resque.redis = Redis.new({
  :host     => HubotFactory::Settings.redis_host,
  :port     => HubotFactory::Settings.redis_port,
  :password => HubotFactory::Settings.redis_pass,
})

Pony.options = {
  :via         => :smtp,
  :via_options => {
    :address              => HubotFactory::Settings.email_host,
    :port                 => HubotFactory::Settings.email_port,
    :domain               => HubotFactory::Settings.email_domain,
    :user_name            => HubotFactory::Settings.email_user,
    :password             => HubotFactory::Settings.email_pass,
    :authentication       => :plain,
    :enable_starttls_auto => true,
  }
}

require "hubot_factory/adapters"
require "hubot_factory/email"
require "hubot_factory/heroku"
require "hubot_factory/hubot"
require "hubot_factory/git"
require "hubot_factory/build_hubot"
require "hubot_factory/app"
require "hubot_factory/views/layout"
require "hubot_factory/version"
