# -*- coding: utf-8 -*-
require 'spec_helper'

describe "StaticPages" do

  describe "Home Page" do
    before do
      visit '/static_pages/home'
    end
    it "Sample App と表示される" do
      expect(page).to have_content('Sample App')
    end
  end

  describe "Help Page" do
    before do
      visit '/static_pages/help'
    end
    it "Help と表示される" do
      expect(page).to have_content('Help')
    end
  end

  describe "About Page" do
    before do
      visit '/static_pages/about'
    end
    it "About Us と表示される" do
      expect(page).to have_content('About Us')
    end
  end
end
