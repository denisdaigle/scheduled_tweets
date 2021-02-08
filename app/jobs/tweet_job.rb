class TweetJob < ApplicationJob

  queue_as :default

  def perform(tweet)
    #context, you can't cancel jobs, so we need to deal with multiple jobs for the same action.
    return if tweet.published? #if original publish_at was later then currently set, and this is an old job.
    return if tweet.publish_at > Time.current #if publish_at is only later, and this is an old job.
    
    tweet.publish_to_twitter!
  end
end
