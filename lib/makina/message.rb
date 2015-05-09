#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

module Makina
  class Message
    attr_reader :users, :messages
    
    def initialize(users, messages)
      @users = users
      @messages = messages
    end
  end
end