require 'spec_helper'
require File.expand_path('../../../lib/sendgrid-newsletter', __FILE__)

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
      }.must_raise ArgumentError
    end

    it 'should return message: "success" on successful creation' do
      VCR.use_cassette('create_list_successfully') do
        subject.add(list: 'Cool List').must_equal({'message' => 'success'})
      end
    end
  end
end
