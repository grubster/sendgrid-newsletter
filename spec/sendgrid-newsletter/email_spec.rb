require 'spec_helper'

describe Sendgrid::Newsletter::Email do
  before do
    Sendgrid::Newsletter::Config.api_user = 'news_test'
    Sendgrid::Newsletter::Config.api_key = 'testnewsletter'
  end
  subject { Sendgrid::Newsletter::Email.new }
  describe '#add' do
    it 'should require list param' do
      lambda {
        subject.add
      }.should raise_error ArgumentError
    end

    it 'should require data param' do
      lambda {
        subject.add list: 'cool_list'
      }.should raise_error ArgumentError
    end

    it 'should require data param to be an hash or an array' do
      lambda {
        subject.add list: 'cool_list', data: 'asdf'
      }.should raise_error ArgumentError
    end

    it 'should raise Sendgrid::Newsletter::FieldsRequired if email or name in data param' do
      lambda {
        subject.add list: 'cool_list', data: { foo: 'bar' }
      }.should raise_error Sendgrid::Newsletter::FieldsRequired
    end

    it 'should return {"inserted": X} where X is the number of emails' do
      VCR.use_cassette('adding_emails_on_list') do
        subject.add(list: 'cool_list', data: [{name: 'foo bar', email: 'foo@bar.com'}, {name: 'foo2 bar', email: 'foo2@bar.com'}]).should eql({'inserted' => 2})
      end
    end

    it 'should send multiple data parameters' do
      VCR.use_cassette('adding_emails_with_data_on_list') do
        subject.add(list: 'cool_list', data: [{name: 'foo bar', email: 'foo@bar.com', address:'2 Street, 0'}, {name: 'foo2 bar', email: 'foo2@bar.com', address:'1 Street, 2'}]).should eql({'inserted' => 2})
      end
    end

    it 'should raise APIError if API return {"error": "message"}' do
      VCR.use_cassette('error_adding_emails_on_list') do
        lambda {
          subject.add(list: 'bad_list', data: [{name: 'foo bar', email: 'foo@bar.com'}, {name: 'foo2 bar', email: 'foo2@bar.com'}])
        }.should raise_error Sendgrid::Newsletter::APIError
      end
    end

    it "should treat adding more than 1000 emails" do
      VCR.use_cassette('adding_bulk_emails_on_list') do
        data = (1..1500).to_a.map { |i| { name: "foo bar #{i}", email: "foo#{i}@bar.com" } }
        subject.add(list: 'cool_list', data: data).should eql({'inserted' => 1499})
      end

    end
  end
end

