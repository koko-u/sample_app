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
      it { should have_selector('div.alert.alert-error', text: '不正') }

      context "エラーの後ホーム画面に戻る" do
        before { click_link 'Home' }
        it "フラッシュメッセージが消える" do
          expect(page).not_to have_selector('div.alert.alert-error', text: '不正')
        end
      end
    end

    context "正規のユーザでサインイン" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in 'Email',    with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      end

      it { should have_title(user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sing out', href: signout_path) }
      it { should_not have_link('Sign in') }
    end
  end
end
