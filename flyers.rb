#!/usr/bin/env ruby
require 'sinatra'
require 'haml'
require 'sass'
require 'mongo'

include Mongo

if ENV['MONGOHQ_URL']
  uri = URI.parse(ENV['MONGOHQ_URL'])
  conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
  db = conn.db(uri.path.gsub(/^\//, ''))
else
  db = Connection.new(ENV['DATABASE_URL'] || 'localhost').db('flyers')
end

get '/' do
  @jersey_numbers = {}
  (0..100).each do |jersey_number|
    players = db['players'].find('numbers' => jersey_number)
    if players.count > 0
      @jersey_numbers[jersey_number] = players
    end  
  end
  haml :index
end

get '/by_name' do
  @players = db['players'].find()
  haml :names
end

# SASS stylesheets
get '/stylesheets/application.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :application
end

get '/stylesheets/iphone.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :iphone
end