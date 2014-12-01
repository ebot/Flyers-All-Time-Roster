#!/usr/bin/env ruby
require 'mongo'
require 'uri'

@mongo_url = 'mongodb://user:pass@server:port/db'

def get_connection
  return @db_connection if @db_connection
  db = URI.parse(@mongo_url)
  db_name = db.path.gsub(/^\//, '')
  @db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
  @db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.password.nil?)
  @db_connection
end

db = get_connection

puts 'Dropping and Recreating Players Collection'

players = db["players"]
players.drop
players = db["players"]

puts 'Collection Created, Adding Players...'

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

puts 'Done'
