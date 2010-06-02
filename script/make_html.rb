#!/usr/bin/env ruby -wKU
require 'RedCloth'

border_style = <<EOT
<style type="text/css">
  table {
    border-collapse: collapse;
    border: solid 1px black;
  }
  
  td, th {
    border: solid 1px black;
  }
</style>

EOT

numbers = {}
names = {}
input = File.new 'flyer_numbers.csv', 'r'
input.each_line do |line|
  line = line.gsub('"', '').chomp
  info = line.split(';')
  
  jersey_number = info[0].to_i
  numbers[jersey_number] = [] if numbers[jersey_number].nil?
  numbers[jersey_number] << "|_<.#{info[2]}|#{info[1]}|#{info[3]}|\n"
  
  player_name = info[2]
  
  if names[player_name].nil?
    names[player_name] = {
      :position => info[1],
      :years => info[3],
      :numbers => []
    }
  end
  names[player_name][:numbers] << info[0].to_i
end

by_num = "h1. Flyers By Jersey Number\n\n"
numbers.sort.each do |number, player_names| 
  by_num << "h2. #{number}\n\n"
  player_names.each { |name| by_num << "#{name}" }
  by_num << "\n"
end

by_name = border_style + "h1. Flyer Jersey Numbers By Name\n\n"
by_name << "|_.Player|_.Position|_.Years as a Flyer|_.Numbers Worn|\n"
names.each do |name, info|
  by_name << "|_<.#{name}|#{info[:position]}|#{info[:years]}|>.#{info[:numbers].join(', ')}|\n"
end

page1 = File.new '../views/numbers.html', 'w'
page2 = File.new '../views/names.html', 'w'

by_num = RedCloth.new by_num
by_name = RedCloth.new by_name

page1 << by_num.to_html
page2 << by_name.to_html

page1.close
page2.close