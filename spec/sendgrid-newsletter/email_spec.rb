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

    it 'should raise APIError if API return {"error": "message"}' do
      VCR.use_cassette('error_adding_emails_on_list') do
        lambda {
          subject.add(list: 'bad_list', data: [{name: 'foo bar', email: 'foo@bar.com'}, {name: 'foo2 bar', email: 'foo2@bar.com'}])
        }.should raise_error Sendgrid::Newsletter::APIError
      end
    end
  end
end

