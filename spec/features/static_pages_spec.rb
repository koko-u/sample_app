# -*- coding: utf-8 -*-
require 'spec_helper'

describe "StaticPages" do
  let(:base_title) { 'Ruby on Rails Tutorial' }
  describe "Home Page" do
    subject { page }
    before do
      visit root_path
    end

    it { should     have_content('Sample App') }
    it { should     have_title(base_title) }
    it { should_not have_title('Home') }
end

  describe "Help Page" do
    subject { page }
    before do
      visit help_path
    end

    it { should have_content('Help') }
    it { should have_title(/Help/) }

  end

  describe "About Page" do
    subject { page }
    before do
      visit about_path
    end

    it { should have_content('About Us') }
    it { should have_title(/About Us/) }
  end

  describe "Contact Page" do
    subject { page }
    before do
      visit contact_path
    end

    it { should have_content('Contact') }
    it { should have_title(/Contact/) }
  end

end
