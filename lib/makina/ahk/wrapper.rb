#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require_relative './dll/ahk'
require_relative './dll/kernel32'

module Makina
  module AHK
    class Wrapper
      def initialize(file)
        AHK::DLL::AHK.ahktextdll(u16(''), u16(''), nil)

        until AHK::DLL::AHK.ahkReady()
          sleep 0.01
        end

        AHK::DLL::AHK.addFile(u16(file), 0, 0)
      end

      def call(*args)
        args.map! {|str| u16(str) }
        fun = AHK::DLL::AHK.ahkFunction[args.size]
        u8(fun.call(*args))
      end

      def terminate(timeout = 0)
        AHK::DLL::AHK.ahkTerminate(timeout)
      end

      def reload
        AHK::DLL::AHK.ahkReload
      end

    protected

      def u16(text)
        (text + 0.chr).encode('UTF-16LE')
      end

      def u8(ptr)
        len = AHK::DLL::Kernel32.lstrlenW(ptr)
        str = ' ' * (len * 2)

        (len * 2).times do |i|
          str.setbyte(i, ptr[i])
        end

        str.encode('UTF-8', 'UTF-16LE')
      end
    end
  end
end
