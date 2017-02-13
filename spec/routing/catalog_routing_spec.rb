# frozen_string_literal: true
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Routing" do
  describe "Paths Generated by Custom Routes:" do
    # paths generated by custom routes
    it "has a path for showing the email form" do
      expect(:get => "/catalog/email").to route_to(:controller => 'catalog', :action => 'email')
    end
    it "has a path for sending the email" do
      expect(:post => "/catalog/email").to route_to(:controller => 'catalog', :action => 'email')
    end
    it "maps GET {:controller => 'catalog', :action => 'sms'} to /catalog/sms" do
      expect(:get => "/catalog/sms").to route_to(:controller => 'catalog', :action => 'sms')
    end
    it "maps POST {:controller => 'catalog', :action => 'sms'} to /catalog/sms" do
      expect(:post => "/catalog/sms").to route_to(:controller => 'catalog', :action => 'sms')
    end
    it "maps { :controller => 'catalog', :action => 'show', :id => 666 } to /catalog/666" do
      expect(:get => "/catalog/666").to route_to(:controller => 'catalog', :action => 'show', :id => "666")
    end
  end


  describe "solr_document_path for SolrDocument", :test => true do
    it "routes correctly" do
      expect(:get => solr_document_path(SolrDocument.new(:id => 'asdf'))).to route_to(:controller => 'catalog', :action => 'show', :id => 'asdf')
    end

    context "should escape solr document ids" do

      it "pass-throughs url-valid ids" do
        expect(:get => solr_document_path(SolrDocument.new(:id => 'qwerty'))).to route_to(:controller => 'catalog', :action => 'show', :id => 'qwerty')
      end

      it "routes url-like ids" do
        skip "This works if you configure your routing to have very liberal constraints on :id.. not sure how to go about testing it though"
        expect(:get => solr_document_path(SolrDocument.new(:id => 'http://example.com'))).to route_to(:controller => 'catalog', :action => 'show', :id => 'http://example.com')
      end

      it "routes ids with whitespace" do
        expect(:get => solr_document_path(SolrDocument.new(:id => 'mm 123'))).to route_to(:controller => 'catalog', :action => 'show', :id => 'mm 123')
      end

      it "routes ids with a literal '+'" do
        expect(:get => solr_document_path(SolrDocument.new(:id => 'this+that'))).to route_to(:controller => 'catalog', :action => 'show', :id => 'this+that')
      end

      it "routes ids with a literal '/" do
        skip "This works if you configure your routing to have very liberal constraints on :id.. not sure how to go about testing it though"
        expect(:get => solr_document_path(SolrDocument.new(:id => 'and/or'))).to route_to(:controller => 'catalog', :action => 'show', :id => 'and/or')
      end
    end
  end
end
