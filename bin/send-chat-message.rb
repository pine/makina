#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require_relative '../lib/makina'

print 'Username: '
username = gets.chomp

print 'Message: '
message = gets.encode(Encoding::UTF_8).chomp

puts 'Starting ...'

skype = Makina::Skype::MainWindow.new

if skype.start
  puts 'OK'
  
  puts "Opening chat for #{username} ..."
  chat = skype.chat([username])
  
  chat.open do |opened|
    puts opened ? 'OK' : 'ERROR'
    chat.send(message)
  end
else
  puts 'ERROR'
end

skype.dispose
