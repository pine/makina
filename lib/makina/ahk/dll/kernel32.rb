#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require 'dl/import'

module Makina
  module AHK
    module DLL
      module Kernel32
        extend DL::Importer
        dlload 'kernel32.dll'
        extern 'int lstrlenW(const wchar_t*)'
      end
    end
  end
end
