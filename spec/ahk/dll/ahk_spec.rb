#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require_relative '../../spec_helper'

describe Makina::AHK::DLL::AHK do
  describe '.ahktextdll' do
    it 'has method' do
      expect(Makina::AHK::DLL::AHK).to respond_to(:ahktextdll)
    end
  end
  
  describe '.ahkReady' do
    it 'has method' do
      expect(Makina::AHK::DLL::AHK).to respond_to(:ahkReady)
    end
  end
  
  describe '.addFile' do
    it 'has method' do
      expect(Makina::AHK::DLL::AHK).to respond_to(:addFile)
    end
  end
  
  describe '.ahkTerminate' do
    it 'has method' do
      expect(Makina::AHK::DLL::AHK).to respond_to(:ahkTerminate)
    end
  end
  
  describe '.ahkFunction' do
    it 'is array' do
      expect(Makina::AHK::DLL::AHK.ahkFunction).to be_a(Array)
    end
    
    1.upto(11) do |i|
      it "#[#{i}] is callable" do
        expect(Makina::AHK::DLL::AHK.ahkFunction[i]).to respond_to(:call)
      end
    end
  end
end