require 'spec_helper'

describe Sendgrid::Newsletter::List do
  before do
    Sendgrid::Newsletter::Config.api_user = 'news_test'
    Sendgrid::Newsletter::Config.api_key = 'testnewsletter'
  end
  subject { Sendgrid::Newsletter::List.new }

  describe '.add' do
    it 'should require :list param' do
      lambda {
        subject.add
      }.should raise_error ArgumentError
    end

    it 'should raise APIError when error is received' do
      VCR.use_cassette('list_exist') do
        lambda {
          subject.add(list: 'Cool List')
        }.should raise_error Sendgrid::Newsletter::APIError
      end
    end

    it 'should return message: "success" on successful creation' do
      VCR.use_cassette('create_list_successfully') do
        subject.add(list: 'Cool List').should eql({'message' => 'success'})
      end
    end
  end

  describe '.del' do
    before do
      Sendgrid::Newsletter::Config.api_user = 'grubster_news_test'
      Sendgrid::Newsletter::Config.api_key = 'grugrutestnewsletter'
    end
    it 'should require :list param' do
      lambda {
        subject.delete
      }.should raise_error ArgumentError
    end

    it 'should raise APIError when error is received' do
      VCR.use_cassette('list_non_exist_on_deletion') do
        lambda {
          subject.delete(list: 'Cool List')
        }.should raise_error Sendgrid::Newsletter::APIError
      end
    end

    it 'should return message: "success" on successful deletion' do
      VCR.use_cassette('delete_list_successfully') do
        subject.delete(list: 'Cool List').should eql({'message' => 'success'})
      end
    end

  end
end
