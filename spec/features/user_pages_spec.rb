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
      it "サインアップページに戻る" do
        expect(page).to have_title('Sign up')
      end
      it "エラーメッセージが表示される" do
        expect(page).to have_content('Nameを入力してください。')
      end
    end

    context "フォームに適切なユーザー情報を入力した" do
      let(:user_name) { 'Test User' }
      before do
        fill_in 'Name',         with: user_name
        fill_in 'Email',        with: 'test.user@example.com'
        fill_in 'Password',     with: 'Passw0rd'
        fill_in 'Confirmation', with: 'Passw0rd'
        click_button submit
      end
      it "ユーザが登録される" do
        expect(User.last.name).to eq(user_name)
      end
      it "ユーザのプロフィールページに遷移する" do
        expect(page).to have_title(user_name)
      end
      it "ウェルカムメッセージが表示される" do
        expect(page).to have_content("Welcome to the Sample App!")
      end
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
