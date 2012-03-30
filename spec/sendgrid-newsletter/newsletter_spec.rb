require 'spec_helper'

describe Sendgrid::Newsletter::Newsletter do
  before do
    Sendgrid::Newsletter::Config.api_user='news_test'
    Sendgrid::Newsletter::Config.api_key='testnewsletter'
  end

  subject {Sendgrid::Newsletter::Newsletter.new}

  describe '.list' do
    it 'should return a list of all newsletters' do
      VCR.use_cassette('list_newsletter') do
        subject.list.should eql [{'name' => 'Teste'}, {'name' => 'Teste API'}]
      end
    end

    it 'should check if a list exist within all newsletters' do
      VCR.use_cassette('check_newsletter') do
        subject.list(:name => 'Inexistent News').should eql []
      end
    end

    it 'should check if a list exist within all newsletters' do
    Sendgrid::Newsletter::Config.api_user='grubster_news_test'
    Sendgrid::Newsletter::Config.api_key='grugrutestnewsletter'
      VCR.use_cassette('existent_check_newsletter') do
        subject.list(:name => 'Cool News').should eql [{'name' => 'Cool News'}]
      end
    end
  end

  describe '.add' do
    it 'should require text' do
      lambda {
        subject.add
      }.should raise_error ArgumentError
    end
    it 'should require html' do
      lambda {
        subject.add text: 'Text'
      }.should raise_error ArgumentError
    end
    it 'should require name' do
      lambda {
        subject.add text: 'Text', html: 'Text'
      }.should raise_error ArgumentError
    end
    it 'should require identity' do
      lambda {
        subject.add text: 'Text', html: 'Text', name: 'Beatiful news'
      }.should raise_error ArgumentError
    end
    it 'should require subject' do
      lambda {
        subject.add text: 'Text', html: 'Text', name: 'Beatiful news', identity: 'Beatiful Girl'
      }.should raise_error ArgumentError
    end
    it 'should return error: "Identity %id% does not exist" with inexistent identity' do
      VCR.use_cassette('inexistent_identity') do
        lambda {
          subject.add text: 'Text', html: 'Text', name: 'Beatiful news', identity: 'Beatiful Girl', subject: 'Text'
        }.should raise_error Sendgrid::Newsletter::APIError
      end
    end
    it 'should return message: "success" on successful creation' do
      VCR.use_cassette('existent_identity') do
        subject.add(text: 'Text', html: 'Text', name: 'Beatiful news', identity: 'Grubster Tech TEST', subject: 'Text').should eql({'message' => 'success'})
      end
    end
  end
end
