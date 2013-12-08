# -*- coding: utf-8 -*-
require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "sign up page" do
    let(:submit) { 'Create my account' }
    before do
      visit signup_path
    end

    it { should have_content('Sign up') }
    it { should have_title('Sign up') }

    context "フォームに何も入力しない" do
      before { click_button submit }

      it "ユーザは登録されない" do
        expect(User.count).to be(0)
      end
      it { should have_title('Sign up') }
      it { should have_error_message('エラー') }
    end

    context "フォームに適切なユーザー情報を入力した" do
      let(:user_name) { 'Test User' }
      before { valid_signup(user_name) }

      it "ユーザが登録される" do
        expect(User.last.name).to eq(user_name)
      end

      it { should be_profile_page_of(user_name) }
      it { should have_content("Welcome to the Sample App!") }
      it { should have_link('Sign out') }
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit user_path(user)
    end

    it { should have_content(user.name) }
    it { should have_title(user.name) }

  end
end
