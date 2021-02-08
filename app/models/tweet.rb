class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: { minimum: 1, maximum: 280 }
  validates :publish_at, presence: true

  after_initialize do
    self.publish_at ||= 24.hours.from_now
  end

  after_save_commit do
    if publish_at_previously_changed?
      TweetJob.set(wait_until: publish_at).perform_later(self) #in case publish at was changed. The tweet job will not run if already published. It hard to cancel a job, so impotent function is best.
    end
  end

  def published?
    tweet_id?
  end   

  def publish_to_twitter!
    tweet = twitter_account.client.update(body)
    update(tweet_id: tweet.id)
  end  

end
