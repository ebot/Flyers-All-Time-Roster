#!/usr/bin/env ruby
require 'rubygems'
require 'mongo'

m = Mongo::Connection.new
m.drop_database('flyers')

db = Mongo::Connection.new("localhost").db("flyers")
players = db["players"]

input = File.new 'flyer_numbers.csv', 'r'
input.each_line do |line|
  line = line.gsub('"', '').chomp
  info = line.split(';')
  
  player = {
    :name => info[2],
    :position => info[1],
    :years => info[3],
    :numbers => [info[0].to_i]
  }
  
  mongo_player = players.find_one(
                  "name" => player[:name],
                  "position" => player[:position],
                  "years" => player[:years] )
  
  if mongo_player.nil?
    players.insert( player )
  else
    mongo_player["numbers"] << info[0].to_i
    players.save( mongo_player )
  end
end