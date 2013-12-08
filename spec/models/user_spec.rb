# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  subject { FactoryGirl.build(:user) }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }

  context "名前とe-mailを持つ場合" do
    it { should be_valid }
  end

  context "名前が無い場合" do
    subject { FactoryGirl.build(:user, name: ' ') }

    it { should be_invalid }
  end

  context "e-mail が無い場合" do
    subject { FactoryGirl.build(:user, email: "\t") }

    it { should be_invalid }
  end

  context "パスワードが無い場合" do
    subject { FactoryGirl.build(:user, password: '', password_confirmation: '') }

    it { should be_invalid }
  end

  context "パスワードが不一致" do
    subject { FactoryGirl.build(:user, password: 'AbcPassWd', password_confirmation: 'UvPassUD') }

    it { should be_invalid }
  end

  context "名前が長すぎる場合" do
    subject { FactoryGirl.build(:user, name: 'a' * 51) }

    it { should be_invalid }
  end

  invalid_addresses = [
    "user@foo,com",
    "user_at_foo.org",
    "example.user@foo.foo@bar_baz.com",
    "foo@bar+baz.com"
  ]
  invalid_addresses.each do |address|
    context "#{address} は e-mail の形式として不正" do
      subject { FactoryGirl.build(:user, email: address) }
      it { should be_invalid }
    end
  end

  valid_addresses = [
    "user@foo.COM",
    "A_US-ER@f.b.org",
    "frst.lst@foo.jp",
    "a+b@baz.cn"
  ]
  valid_addresses.each do |address|
    context "#{address} は e-mail の形式としてOK" do
      subject { FactoryGirl.build(:user, email: address) }
      it { should be_valid }
    end
  end

  context "既に user@example.com のアドレスでユーザー登録されている" do
    let(:address) { 'user@example.com' }
    before { FactoryGirl.create(:user, email: address) }
    context "同じメールアドレスの場合" do
      subject { FactoryGirl.build(:user, email: address) }
      it { should be_invalid }
    end
    context "大文字小文字の違いしかないメールアドレスの場合" do
      subject { FactoryGirl.build(:user, email: address.upcase) }
      it { should be_invalid }
    end
  end

  context "同じメールアドレスを持つ複数のユーザを同時に登録した場合" do
    let(:address) { 'aaa@example.com' }
    before do
      one = FactoryGirl.build(:user, name: 'one', email: address)
      two = FactoryGirl.build(:user, name: 'two', email: address)
      one.save
      two.save
    end
    it { expect(User.where(email: address).count).to be(1) }
  end

  context "大文字小文字混じりのe-mailの場合" do
    let(:address) { 'Foo@Bar.CoM' }
    let(:user) { FactoryGirl.build(:user, email: address) }
    before { user.save }
    it { expect(user.email).to eq(address.downcase) }
  end

  context "#authenticate" do
    let(:passwd) { 'PassW0rd' }
    let(:user) { FactoryGirl.create(:user, password: passwd) }
    it { should respond_to(:authenticate) }

    context "パスワードが一致する場合" do
      subject { user.authenticate(passwd) }

      it { should eq user }
    end

    context "パスワードが一致しない場合" do
      subject { user.authenticate('WongPasswd') }

      it { should be_false }
    end
  end

  context "パスワードが短かすぎる" do
    let(:short_passwd) { 'a' * 5 }
    subject { FactoryGirl.build(:user, password: short_passwd, password_confirmation: short_passwd) }

    it { should be_invalid }
  end

  context "記憶トークン" do
    subject(:user) { FactoryGirl.build(:user, remember_token: nil) }
    before { user.save }
    its(:remember_token) { should be_present }
  end
end
