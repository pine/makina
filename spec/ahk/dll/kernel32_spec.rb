#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require_relative '../../spec_helper'

describe Makina::AHK::DLL::Kernel32 do
  describe '.lstrlenW' do
    it 'should return length' do
      u8 = 'あいうえお'
      u16 = (u8 + 0.chr).encode('UTF-16LE')
      
      expected = u8.size
      actual = Makina::AHK::DLL::Kernel32.lstrlenW(u16)
      
      expect(u8).not_to eq(u16)
      expect(actual).to eq(expected)
    end
  end
end
