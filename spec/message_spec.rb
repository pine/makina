#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require_relative './spec_helper'

describe Makina::Message do
  describe '#initialize' do
    it 'should have members' do
      msg = Makina::Message.new(['username'], ['message'])
      
      expect(msg.users).to eq(['username'])
      expect(msg.messages).to eq(['message'])
    end
  end
end
