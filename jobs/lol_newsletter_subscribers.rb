require 'gibbon'

MAILCHIMP_API_KEY = ENV['MAILCHIMP_API_KEY']
gibbon = Gibbon::API.new(MAILCHIMP_API_KEY)
current_subscribers = 0
puts "Mailchimp initialised with API KEY: #{MAILCHIMP_API_KEY}"
SCHEDULER.every '1m', :first_in => 0 do
  puts "Mailchimp: Fetching list"
  last_subscribers = current_subscribers

  # Get subscriber count
  lists = gibbon.lists.list({:filters => {:list_name => "League of Legends Newsletter"}})
  list = lists['data'][0]
  current_subscribers = list['stats']['member_count']
  gained = list['stats']['member_count_since_send']
  last_subscribers = current_subscribers - gained

  puts "Mailchimp: Got data"

  send_event('lol-newsletter-subscribers', {
    current: current_subscribers,
    last: last_subscribers
  })
end
