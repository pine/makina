#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

# Set sikulixapi.jar path
module Makina
  module SikulixLoader
    @@loaded = false
    
    def self.load
      return if @@loaded
      @@loaded = true
      
      Proc.new {
        bin_path = File.expand_path('../../bin/', File.dirname(__FILE__))
        ENV['SIKULIXAPI_JAR'] = File.expand_path('sikulix/sikulixapi.jar', bin_path)
      }.call

      require 'sikulix'

      Proc.new {
        images_path = File.expand_path('../../../assets/images/', __FILE__)
        Sikulix::ImagePath.reset(images_path)
        Sikulix::Settings.OcrTextRead = true
      }.call
    end
  end
end
