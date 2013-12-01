# -*- coding: utf-8 -*-
require 'spec_helper'

describe "StaticPages" do
  let(:base_title) { 'Ruby on Rails Tutorial' }
  describe "Home Page" do
    before do
      visit '/static_pages/home'
    end
    it "Sample App と表示される" do
      expect(page).to have_content('Sample App')
    end

    it "タイトルが表示される" do
      expect(page).to have_title(base_title)
    end

    it "Home とは表示されない" do
      expect(page).not_to have_title('Home')
    end
end

  describe "Help Page" do
    before do
      visit '/static_pages/help'
    end
    it "Help と表示される" do
      expect(page).to have_content('Help')
    end

    it "適切なタイトルが表示される" do
      expect(page).to have_title(/Help/)
    end
  end

  describe "About Page" do
    before do
      visit '/static_pages/about'
    end
    it "About Us と表示される" do
      expect(page).to have_content('About Us')
    end

    it "適切なタイトルが表示される" do
      expect(page).to have_title(/About Us/)
    end
  end

end
