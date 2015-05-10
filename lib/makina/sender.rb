#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require 'logger'

module Makina
  class Sender
    def initialize(log = nil)
      @log = log || Logger.new(STDOUT)
      @skype = Makina::Skype::MainWindow.new
    end
    
    def dispose
      @skype.dispose
    end
  end
end