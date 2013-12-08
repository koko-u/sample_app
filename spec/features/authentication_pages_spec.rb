# -*- coding: utf-8 -*-
require 'spec_helper'

describe "認証機能" do
  subject { page }

  describe "サインインページ" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }

    context "何も入力せずにサインイン" do
      before { click_button 'Sign in' }

      it { should have_title('Sign in') }
      it { should have_error_message('不正') }

      context "エラーの後ホーム画面に戻る" do
        before { click_link 'Home' }

        it "エラーメッセージがクリアされる" do
          should_not have_error_message('不正')
        end
      end
    end

    context "正規のユーザでサインイン" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should be_profile_page_of(user) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in') }

      context "サインアウトする" do
        before { click_link('Sign out') }

        it { should have_link('Sign in') }
      end
    end
  end
end
