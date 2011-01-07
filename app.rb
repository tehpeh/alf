require 'rubygems'
require 'sinatra/base'
require 'sinatra/reloader'
require 'haml'
require 'rest_client'
require 'json'

module Alf
  class App < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
    end
    
    set :alfresco_host, 'localhost'
    set :alfresco_port, 8080
    set :alfresco_username, ''
    set :alfresco_password, ''
    
    get '/' do
      @title = "Alf"
      @login = RestClient.post "http://#{settings.alfresco_host}:#{settings.alfresco_port}/alfresco/service/api/login", 
        { :username => settings.alfresco_username, 
          :password => settings.alfresco_password }.to_json, 
        :content_type => :json, 
        :accept => :json
        
      haml :index
    end
    
    not_found do
      "Go away"
    end
  end
end