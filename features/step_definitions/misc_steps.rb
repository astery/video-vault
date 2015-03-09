Given(/^a regular user "(.*?)"$/) do |name|
  User.create!(name: name, email: "#{name}@example.com", password: 'password', confirmed_at: Time.now)
end

Given(/^a banned user "(.*?)"$/) do |name|
  User.create!(name: name, email: "#{name}@example.com", password: 'password', confirmed_at: Time.now, role: :read_only_user)
end

Given(/^I am logged as "(.*?)"$/) do |name|
  u = User.find_by_name!(name)
  signin(u.email, 'password')
end

When(/^I try to upload "(.*?)" video$/) do |name|
  visit new_video_path
  fill_in :video_title, :with => name

  # TODO: ask capybara folks about it
  # Some inconsistence between real and test environment
  # In real mime detection goes with file unix utility (output: video/mp4, video/webm)
  # In test I suppose it goes through Mime::Types (output: application/mp4, music/webm)
  # For now use just files with 'video/x-msvideo' type compiled with libx264

  attach_file :video_file, File.join(file_fixtures_dir, "#{name}.avi")
  click_button 'Create Video'
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^I should see "(.*?)" in videos list$/) do |text|
  visit videos_path
  expect(page).to have_content(text)
end

When(/^I try to upload "(.*?)" videos$/) do |_arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)" error$/) do |_arg1|
  pending # express the regexp above with the code you wish you had
end

Given(/^"(.*?)" uploaded "(.*?)" video for birthday$/) do |user_name, video_title|
  @user = User.find_by_name!(user_name)
  @deliver_time = Time.now + 10.days

  Rails.configuration.use_transactional_fixtures = false
  File.open file_fixtures_dir("#{video_title}.avi") do |file|
    @video = Video.create!(title: video_title, show_at: @deliver_time, file: file, user: @user)
  end
end

When(/^birthday time is come$/) do
  VideoMailHandler.new(@video).call(nil, nil)

  # TODO: make proper time emulation trigger
  # VideoMailSchedulerHandler - called by Rufus::Scheduler work in separate thread
  # I am unable to interact with it properly
  # Code below is work but too ugly and in end of road do the same
  #
  # Timecop.freeze(@deliver_time)
  # interval = Rufus::Scheduler.parse_duration(Rails.configuration.x.mail_processing.schedule)
  # VideoMailSchedulerHandler.new(interval).call(nil, nil)
  # Rufus::Scheduler.s.jobs.each { |j| j.trigger(@deliver_time) }

end

Then(/^"(.*?)" should recieve mail with "(.*?)" video$/) do |user_name, video_title|
  mail = ActionMailer::Base.deliveries.last
  expect(mail.body.encoded).to have_xpath("//a[@href='#{video_url(@video, host: Rails.application.secrets.domain_name )}']")
end
