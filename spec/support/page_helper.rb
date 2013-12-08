module PageHelper
  def valid_signin(user)
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

  def valid_signup(name, pass='Passw0rd')
    fill_in 'Name',         with: name
    fill_in 'Email',        with: "#{name.gsub(/\s+/, '')}@example.com"
    fill_in 'Password',     with: pass
    fill_in 'Confirmation', with: pass
    click_button submit
  end
end
