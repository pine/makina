#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require_relative '../spec_helper'

describe Makina::Skype::Path do
  describe '.find_exec_path' do
    context 'programfiles only' do
      it 'should return Skype path' do
        path = File.expand_path('../../files/program_files/', __FILE__)
        allow(ENV).to receive(:[]).with('programfiles').and_return(path)
        allow(ENV).to receive(:[]).with('programfiles(x86)').and_return('')
        
        expected = File.expand_path('Skype/Phone/Skype.exe', path)
        actual = Makina::Skype::Path.find_exec_path()
        expect(actual).to eq(expected)
      end
      
      it 'shouldn\'t return Skype path' do
        allow(ENV).to receive(:[]).with('programfiles').and_return('')
        allow(ENV).to receive(:[]).with('programfiles(x86)').and_return('')
        
        actual = Makina::Skype::Path.find_exec_path()
        expect(actual).to be_falsy
      end
    end
  end
end
