#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require_relative './spec_helper'

describe Makina::Sender do
  describe '#initialize' do
    it 'create instance' do
      expect {
        Makina::Sender.new
      }.not_to raise_error
    end
  end
end
