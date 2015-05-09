#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

module Makina
  module Skype
    module URI
      def self.open(uri)
        system 'rundll32.exe url,FileProtocolHandler "' + uri + '"'
      end

      # create(['userid_1', 'userid_2'], 'chat')
      def self.create(users, action)
        'skype:' + users.join(';') + '?' + action
      end

      def self.chat(users)
        create(users, 'chat')
      end
    end
  end
end
