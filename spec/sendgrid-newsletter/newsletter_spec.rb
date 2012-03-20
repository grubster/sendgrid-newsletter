require 'spec_helper'
require File.expand_path('../../../lib/sendgrid-newsletter', __FILE__)

describe Sendgrid::Newsletter::Newsletter do
  subject {Sendgrid::Newsletter::Newsletter.new}
  describe '.list' do
    it 'should return a list of all newsletters' do
      Sendgrid::Newsletter::Config.api_user='grubster_news_test'
      Sendgrid::Newsletter::Config.api_key='grugrutestnewsletter'
      VCR.use_cassette('list_newsletter') do
        subject.list.must_equal [{'name' => 'Teste'}, {'name' => 'Teste API'}]
      end
    end
  end
end
