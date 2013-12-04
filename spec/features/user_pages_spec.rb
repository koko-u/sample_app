# -*- coding: utf-8 -*-
require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "sign up page" do
    before do
      visit signup_path
    end

    it { should have_content('Sign up') }
    it { should have_title('Sign up') }
  end
end
