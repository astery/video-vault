Given(/^a regular user "(.*?)"$/) do |name|
  User.create!(name: name, email: "#{name}@example.com", password: 'password', confirmed_at: Time.now)
end

Given(/^a banned user "(.*?)"$/) do |name|
  User.create!(name: name, email: "#{name}@example.com", password: 'password', confirmed_at: Time.now, role: :read_only_user)
end

Given(/^I am logged as "(.*?)"$/) do |name|
  u = User.find_by_name!(name)
  authenticate(u)
end

When(/^I try to upload "(.*?)" video$/) do |_arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)"$/) do |_arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)" in videos list$/) do |_arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I try to upload "(.*?)" videos$/) do |_arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)" error$/) do |_arg1|
  pending # express the regexp above with the code you wish you had
end

Given(/^"(.*?)" uploaded "(.*?)" video$/) do |_arg1, _arg2|
  pending # express the regexp above with the code you wish you had
end

Given(/^this video must be delivered at specific time$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^this time is come$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^"(.*?)" should recieve mail with "(.*?)" video$/) do |_arg1, _arg2|
  pending # express the regexp above with the code you wish you had
end
