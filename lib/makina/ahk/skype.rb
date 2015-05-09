#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require_relative './wrapper'

module Makina
  module AHK
    class Skype < Wrapper
      def initialize
        super(File.expand_path('../skype.ahk', __FILE__))
      end

      def skype_running?
        call('IsSkypeRunning') == '0'
      end

      def skype_start(path)
        call('StartSkypeProcess', path) == '0'
      end

      def skype_get_contact_window_pos
        pos = call('GetContactInfoWindowPos')
        pos.split(',').map {|i| i.to_i } # x, y, w, h
      end

      def skype_wait_contact_info
        call('WaitActiveContactInfoWindow')
      end

      def skype_close_contact_info
        call('CloseContactInfoWindow')
      end
      
      def skype_activate_main_window
        call('ActivateSkypeMainWindow')
      end
    end
  end
end