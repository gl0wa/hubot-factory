module HubotFactory
  class App < Sinatra::Base
    register Mustache::Sinatra

    set :app_file, __FILE__
    set :static,   true

    set :mustache, {
      :namespace => HubotFactory,
      :views     => "#{root}/views",
      :templates => "#{root}/templates"
    }

    not_found do
      @title = "Uh oh! Not Found - Hubot Factory"
      mustache :not_found
    end

    error do
      @title = "Oops! Error - Hubot Factory"
      mustache :error
    end

    get "/" do
      mustache :index
    end

    post "/build" do
      @email        = params[:email]
      @name         = params[:name]
      @adapter      = params[:adapter]

      @adapter_vars = params.keys.grep(/^adapter-/i).map do |k|
        { :var => k[8..-1], :val => params[k] }
      end

      @adapter_vars.select! do |item|
        item[:val] && item[:val] != ""
      end

      Resque.enqueue(BuildHubot, @email, @name, nil, @adapter, @adapter_vars)
      @title = "Your Hubot is being Built - Hubot Factory"
      mustache :build
    end

    get "/janky" do
      mustache :janky
    end

    post "/janky/build" do
      @email = params[:email]

      @config_vars = params.keys.grep(/^config-/i).map do |k|
        { :var => k[7..-1], :val => params[k] }
      end

      @config_vars.select! do |item|
        item[:val] && item[:val] != ""
      end

      Resque.enqueue(BuildJanky, @email, @config_vars)
      @title = "Your Janky is being deployed - Hubot Factory"
      mustache :build_janky
    end

    get "/api_docs" do
      mustache :api_docs
    end

    get "/about" do
      @title = "About - Hubot Factory"
      mustache :about
    end
  end
end
