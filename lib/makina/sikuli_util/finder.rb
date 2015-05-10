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
        
        catch(:exit) do
          begin
            timeout(sec) do
              loop do
                patterns.each do |p|
                  match = region.exists(p, 0)
                  throw :exit, match if match
                end
              end
            end
          rescue Timeout::Error
            throw :exit, nil
          end
        end
      end
    end
  end
end