module PageMatcher
  RSpec::Matchers.define :have_error_message do |message|
    match do |page|
      page.has_selector?('div.alert.alert-error', text: message)
    end

    failure_message_for_should do |page|
      "expect to find the error message #{message} in the page : #{page.text}"
    end

    failure_message_for_should_not do |page|
      "expect not to find the error message #{message} in the page : #{page.text}"
    end
  end

  RSpec::Matchers.define :be_profile_page_of do |user|
    user_name = user.try(:name) || user
    match do |page|
      page.has_title?(user_name)
    end

    failure_message_for_should do |page|
      "expect to be #{user_name} profile page, but the page title is #{page.title}"
    end
  end
end
