#!/usr/bin/env ruby
require 'sinatra'
require 'haml'
require 'sass'

# iphone index
#get '/', :agent => /Mobile|webOS/ do
#  haml :iphone, :layout => false
#end

# index
get '/' do
  haml :index, :encoding => 'utf-8'
end

get '/by_name' do
  haml :names
end

# SASS stylesheets
get '/stylesheets/application.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :application
end