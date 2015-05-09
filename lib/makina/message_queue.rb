#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require 'logger'
require 'thread'

module Makina
  class MessageQueue
    def initialize(log = nil)
      @log = log || Logger.new(STDOUT)
      @q = Queue.new
      @thread = nil
    end
    
    def push(message)
      @q.push(message)
    end
    
    def start
      @thread = Thread.new do
        
      end
    end
    
    def stop
      
    end
  end
end