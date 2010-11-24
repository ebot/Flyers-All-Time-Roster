#!/usr/bin/env ruby -wKU

input = File.new 'flyer_numbers-2010-2011.txt', 'r'
out1 = File.new 'flyer_numbers-2010-2011.csv', 'w'
out2 = File.new 'flyer_numbers.csv', 'w'

input.each_line do |line|
  player = line.chomp.split('|')
  position = player[1]
  name     = player[2]
  years    = player[3]
  unless player[0].index(',').nil?
    numbers = player[0].split(', ')
    numbers.each do |number|
      out1 << number + ';"' + position + '";"' + name + '";"' + years + "\"\n"
      out2 << number + ';"' + position + '";"' + name + '";"' + years + "\"\n"
    end
  else
    out1 << player[0] + ';"' + position + '";"' + name + '";"' + years + "\"\n"
    out2 << player[0] + ';"' + position + '";"' + name + '";"' + years + "\"\n"
    out1.flush
    out2.flush
  end
end

out1.close
out2.close