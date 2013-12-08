# -*- coding: utf-8 -*-
require 'spec_helper'

describe "認証機能" do
  subject { page }

  describe "サインインページ" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end
end
