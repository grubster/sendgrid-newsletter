require 'spec_helper'
require File.expand_path('../../../lib/sendgrid-newsletter', __FILE__)

describe Sendgrid::Newsletter::Newsletter do
  before do
    Sendgrid::Newsletter::Config.api_user='news_test'
    Sendgrid::Newsletter::Config.api_key='testnewsletter'
  end

  subject {Sendgrid::Newsletter::Newsletter.new}

  describe '.list' do
    it 'should return a list of all newsletters' do
      VCR.use_cassette('list_newsletter') do
        subject.list.must_equal [{'name' => 'Teste'}, {'name' => 'Teste API'}]
      end
    end
  end

  describe '.add' do
    it 'should require text' do
      lambda {
        subject.add
      }.must_raise ArgumentError
    end
    it 'should require html' do
      lambda {
        subject.add text: 'Text'
      }.must_raise ArgumentError
    end
    it 'should require name' do
      lambda {
        subject.add text: 'Text', html: 'Text'
      }.must_raise ArgumentError
    end
    it 'should require identity' do
      lambda {
        subject.add text: 'Text', html: 'Text', name: 'Beatiful news'
      }.must_raise ArgumentError
    end
    it 'should require subject' do
      lambda {
        subject.add text: 'Text', html: 'Text', name: 'Beatiful news', identity: 'Beatiful Girl'
      }.must_raise ArgumentError
    end
    it 'should return error: "Identity %id% does not exist" with inexistent identity' do
      VCR.use_cassette('inexistent_identity') do
        lambda {
          subject.add text: 'Text', html: 'Text', name: 'Beatiful news', identity: 'Beatiful Girl', subject: 'Text'
        }.must_raise Sendgrid::Newsletter::APIError
      end
    end
    it 'should return message: "success" on successful creation' do
      VCR.use_cassette('existent_identity') do
        subject.add(text: 'Text', html: 'Text', name: 'Beatiful news', identity: 'Grubster Tech TEST', subject: 'Text').must_equal({'message' => 'success'})
      end
    end
  end
end
