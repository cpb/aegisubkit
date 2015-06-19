# coding: utf-8
require 'spec_helper'

describe Aegisubkit::ASS do
  before do
    Treetop.load File.expand_path('../../../lib/aegisubkit/ass', __FILE__)
    @file_path = File.expand_path('../../fixtures/example.ass', __FILE__)
    @result = Aegisubkit::ASS.import(@file_path)
  end

  it 'should parser ass format file success' do
    expect(@result).not_to be_nil
  end

  it 'should contains script infos' do
    expect(@result[:info]).not_to be_nil
    expect(@result[:info]).to be_kind_of String
  end

  it 'should have events' do
    expect(@result[:events]).not_to be_nil
    expect(@result[:events]).to be_kind_of Array
  end

  it 'events should have correct attrs' do
    event = @result[:events].first
    %w(start end caption id).each do |k|
      expect(event.key?(k.to_sym)).to be_truthy
    end
  end

  it 'should parse event correctly' do
    captions = @result[:events].map { |x| x[:caption] }
    expect(captions.include?("The man and women")).to be_truthy
  end

  it 'should have audio metadata' do
    expect(@result[:audio_metadata]).not_to be_nil
    expect(@result[:audio_metadata]).to be_kind_of Hash
  end
end
