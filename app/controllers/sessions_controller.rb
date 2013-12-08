# -*- coding: utf-8 -*-
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'ユーザ名またはパスワードが不正です'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private
  def session_params
    {
      email: params[:session][:email].downcase,
      password: params[:session][:password]
    }
  end

end
