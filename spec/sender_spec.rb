#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require_relative './spec_helper'

describe Makina::Sender do
  describe '#initialize' do
    it 'create instance' do
      sender = nil
      
      expect {
        sender = Makina::Sender.new
      }.not_to raise_error
      
      sender.dispose rescue nil
    end
  end
  
  describe '#dispose' do
    it 'has method' do
      sender = Makina::Sender.new
      expect(sender).to respond_to(:dispose)
      sender.dispose rescue nil
    end
    
    it 'succeeds' do
      sender = Makina::Sender.new
      expect { sender.dispose }.not_to raise_error
    end
  end
end
