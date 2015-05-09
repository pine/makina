#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require 'timeout'
require_relative './loader'

module Makina
  module SikuliUtil
    module Finder
      def self.find_any(region, image_paths, sec)
        patterns = image_paths.map do |path|
          Sikulix::Pattern.new(path).exact
        end
        
        begin
          timeout(sec) do
            patterns.each do |p|
              region.exists(p, 0)
            end
          end
        rescue Timeout::Error
          nil
        end
      end
    end
  end
end