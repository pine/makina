#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

module Makina
  module SikuliUtil
    module Loader
      @@loaded = false
      
      def self.load
        return if @@loaded
        @@loaded = true

        Proc.new {
          bin_path = File.expand_path('../../../../bin/', __FILE__)
          ENV['SIKULIXAPI_JAR'] = File.expand_path('sikulix/sikulixapi.jar', bin_path)
        }.call

        require 'sikulix'

        Proc.new {
          images_path = File.expand_path('../../../../assets/images/', __FILE__)
          Sikulix::ImagePath.reset(images_path)
          Sikulix::Settings.OcrTextRead = true
        }.call
      end
    end
  end
end