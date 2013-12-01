RSpec.configure do |config|
  config.before(:all, js: true) do
    Capybara.current_driver = :webkit
  end
  config.after(:all, js: true) do
    Capybara.use_default_driver
  end
end
