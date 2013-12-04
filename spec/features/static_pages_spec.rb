# -*- coding: utf-8 -*-
require 'spec_helper'

shared_examples "desired page with" do |params|
  it { should have_content(params[:heading]) }
  it { should have_title(params[:title]) }
end

describe "StaticPages" do
  subject { page }

  describe "Home Page" do
    before { visit root_path }

    it_behaves_like "desired page with", heading: 'Sample App', title: 'Ruby on Rails Tutorial'
    it { should_not have_title('Home') }
  end

  describe "Help Page" do
    before { visit help_path }

    it_behaves_like "desired page with", heading: 'Help', title: 'Help'
  end

  describe "About Page" do
    before { visit about_path }

    it_behaves_like "desired page with", heading: 'About Us', title: 'About Us'
  end

  describe "Contact Page" do
    before { visit contact_path }

    it_behaves_like "desired page with", heading: 'Contact', title: 'Contact'
  end

end

describe "Page Transit" do
  subject { page }
  context "At Home Page" do
    before { visit root_path }

    context "Click Help Link" do
      before { click_link "Help" }
      it { should have_title('Help') }
    end

    context "Click About Link" do
      before { click_link "About" }
      it { should have_title('About Us') }
    end

    context "Click Contact Link" do
      before { click_link "Contact" }
      it { should have_title('Contact') }
    end

    context "Click Home Link" do
      before { click_link "Home" }
      it { should have_content('Welcome') }
    end

    context "Click Signup Button" do
      before { click_link "Sign up now!" }
      it { should have_title('Sign up') }
    end
  end
end
