#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require './lib/makina'


skype = Makina::Skype::MainWindow.new('C:\\Program Files (x86)\\Skype\\Phone\\Skype.exe')
skype.start

chat = skype.chat(['jiurukai'])

chat.open do
  chat.send 'にゃんぱす'
end

skype.dispose
