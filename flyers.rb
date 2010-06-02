#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'mongo'

include Mongo

DB = Connection.new(ENV['DATABASE_URL'] || 'localhost').db('flyers')
if ENV['DATABASE_USER'] && ENV['DATABASE_PASSWORD']
  auth = DB.authenticate(ENV['DATABASE_USER'], ENV['DATABASE_PASSWORD'])
end


# index
get '/' do
  @jersey_numbers = {}
  (0..100).each do |jersey_number|
    players = DB['players'].find('numbers' => jersey_number)
    if players.count > 0
      @jersey_numbers[jersey_number] = players
    end  
  end
  haml :index
end

get '/by_name' do
  @players = DB['players'].find()
  haml :names
end

# SASS stylesheets
get '/stylesheets/application.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :application
end