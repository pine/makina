#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require 'dl/import'

module Makina
  module AHK
    module DLL
      module AHK
        extend DL::Importer

        # dlload 'AutoHotkey.dll'
        Proc.new {
          bin_path = File.expand_path('../../../../../bin/', __FILE__)
          dll_path = File.join(bin_path, 'AutoHotkey32.dll')

          if DL::SIZEOF_VOIDP == 8 # if use 64 bit JVM
            dll_path.sub!(/\d+(?:.dll\z)/, '64')
          end

          dlload dll_path
        }.call

        extern 'void* ahktextdll(const char*, const char*, void*)', :cdecl
        extern 'int   ahkReady()', :cdecl
        extern 'void* addFile(const char*, unsigned char, unsigned char)', :cdecl
        extern 'int   ahkTerminate(int)', :cdecl
        extern 'void  ahkReload()', :cdecl

        # extern 'void* ahkFunction(const char*, const char*, ...)'
        @@ahkFunction = []
        def self.ahkFunction
          @@ahkFunction
        end

        Proc.new {
          cfun = DL::CFunc.new(
            import_symbol('ahkFunction'), DL::TYPE_VOIDP, 'ahkFunction', :cdecl)

          1.upto(11) do |i|
            argtypes = Array.new(i, DL::TYPE_VOIDP)
            @@ahkFunction[i] = DL::Function.new(cfun, argtypes)
          end
        }.call
      end
    end
  end
end