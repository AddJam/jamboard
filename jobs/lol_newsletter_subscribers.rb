current_subscribers = 0
SCHEDULER.every '1s' do
  last_subscribers = current_subscribers

  current_subscribers = rand(2000)
  send_event('lol-newsletter-subscribers', {
    current: current_subscribers,
    last: last_subscribers
  })
end
