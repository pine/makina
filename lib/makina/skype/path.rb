#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

module Makina
  module Skype
    module Path
      def self.find_exec_path
        program_file_paths
          .map {|p| File.absolute_path(File.join(p, 'Skype/Phone/Skype.exe')) }
          .find {|p| FileTest.exists? p }
      end
      
      protected
      
      def self.program_file_paths
        [ ENV['programfiles'], ENV['programfiles(x86)'] ].uniq
      end
    end
  end
end
