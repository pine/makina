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
end
