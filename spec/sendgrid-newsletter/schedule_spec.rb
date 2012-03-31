require 'spec_helper'

describe Sendgrid::Newsletter::Schedule do
  before do
    Sendgrid::Newsletter::Config.api_user = 'news_test'
    Sendgrid::Newsletter::Config.api_key = 'testnewsletter'
  end
  subject { Sendgrid::Newsletter::Schedule.new }
  describe '#add' do
    it 'should require name param' do
      lambda {
        subject.add
      }.should raise_error ArgumentError
    end

    it 'should return {"message" => "success"} when succesffuly scheduled ?' do
      VCR.use_cassette('adding_schedule_to_newsletter') do
        subject.add(name: 'Cool News', after: 90).should eql({'message' => 'success'})
      end
    end

    it 'should raise APIError if API return {"error": "message"}' do
      VCR.use_cassette('error_adding_schedule_to_newsletter') do
        lambda {
          subject.add(name: 'Bad News')
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

    it 'should return {"message" => "success"} when succesffuly destroyied schedule' do
      VCR.use_cassette('removing_schedule_from_newsletter') do
        subject.delete(name: 'Cool News').should eql({'message' => 'success'})
      end
    end

    it 'should raise APIError if API return {"error": "message"}' do
      VCR.use_cassette('error_removing_schedule_to_newsletter') do
        lambda {
          subject.delete(name: 'Bad News')
        }.should raise_error Sendgrid::Newsletter::APIError
      end
    end
  end
end
