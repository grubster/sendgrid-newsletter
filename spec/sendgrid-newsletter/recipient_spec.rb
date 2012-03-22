require 'spec_helper'

describe Sendgrid::Newsletter::Recipient do
  before do
    Sendgrid::Newsletter::Config.api_user = 'grubster_news_test'
    Sendgrid::Newsletter::Config.api_key = 'grugrutestnewsletter'
  end
  subject { Sendgrid::Newsletter::Recipient.new }
  describe '#add' do
    it 'should require name param' do
      lambda {
        subject.add
      }.should raise_error ArgumentError
    end

    it 'should require list param' do
      lambda {
        subject.add name: 'Cool News'
      }.should raise_error ArgumentError
    end

    it 'should return {"message" => "success"} when succesffuly attached emails' do
      VCR.use_cassette('adding_recipients_to_newsletter') do
        subject.add(name: 'Cool News', list: 'cool_list').should eql({'message' => 'success'})
      end
    end

    it 'should raise APIError if API return {"error": "message"}' do
      VCR.use_cassette('error_adding_recipients_to_newsletter') do
        lambda {
          subject.add(name: 'Bad News', list: 'bad_list')
        }.should raise_error Sendgrid::Newsletter::APIError
      end
    end
  end

  describe '#delete' do
    it 'should require name param' do
      lambda {
        subject.delete
      }.should raise_error ArgumentError
    end

    it 'should require list param' do
      lambda {
        subject.delete name: 'Cool News'
      }.should raise_error ArgumentError
    end

    it 'should return {"message" => "success"} when succesffuly destroyied recipient' do
      VCR.use_cassette('removing_recipients_from_newsletter') do
        subject.delete(name: 'Cool News', list: 'cool_list').should eql({'message' => 'success'})
      end
    end

    it 'should raise APIError if API return {"error": "message"}' do
      VCR.use_cassette('error_removing_recipients_to_newsletter') do
        lambda {
          subject.delete(name: 'Bad News', list: 'bad_list')
        }.should raise_error Sendgrid::Newsletter::APIError
      end
    end
  end
end

