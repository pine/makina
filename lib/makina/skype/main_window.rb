#!/usr/bin/ruby
# -*- encoding: utf-8 -*-


require_relative './uri'
require_relative './chat'
require_relative './path'

module Makina
  module Skype
    class MainWindow
      attr_reader :skype_path, :screen, :ahk

      def initialize(skype_path = nil)
        Makina::SikulixLoader::load
        
        @skype_path = skype_path || Makina::Skype::Path.find_exec_path
        @ahk = Makina::AHK::Skype.new
        @screen = Sikulix::Screen.new
      end

      def start
        if @ahk.skype_running?
          true
        else
          @ahk.skype_start(@skype_path)
        end
      end

      def activate
        @ahk.skype_activate_main_window
        wait_visible
      end

      def wait_visible
        pattern = Sikulix::Pattern.new('main_window.png').exact
        pattern2 = Sikulix::Pattern.new('main_window2.png').exact

        unless @screen.wait(pattern, 5)
          @screen.wait(pattern2, 5)
        end
      end

      def wait_active
        @ahk.call('WaitActiveSkypeMainWindow')
      end

      def chat(users)
        Skype::Chat.new(self, users)
      end

      def dispose
        @ahk.terminate
      end
    end
  end
end
