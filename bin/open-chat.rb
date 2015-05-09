#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require_relative '../lib/makina'

print 'Username: '
username = gets.chomp

puts 'Starting ...'

skype = Makina::Skype::MainWindow.new

if skype.start
  puts 'OK'
  
  puts "Opening chat for #{username} ..."
  chat = skype.chat([username])
  
  if chat.open
    puts 'OK'
  end
else
  puts 'ERROR'
end

skype.dispose
