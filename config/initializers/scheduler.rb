require 'rufus-scheduler'

class VideoMailHandler
  def initialize(video)
    @video = video
  end
  def call(job, time)
    Rails.logger.info "[#{time}] #{@video.id} - '#{@video.title}' Has been sended"
    UserMailer.video_from_past(@video).deliver_now
  end
end

class VideoMailSchedulerHandler
  def initialize(interval)
    @interval = interval
  end

  def call(job, time)
    Rails.logger.info "[#{Time.now}] Process videos ready to mail"

    Video.need_to_be_scheduled_for(@interval).each do |v|
      puts 'We have a video! #{v.title}'
      Rufus::Scheduler.singleton.at(v.show_at, VideoMailHandler.new(v))
    end
  end
end

interval = Rufus::Scheduler.parse_duration(Rails.configuration.x.mail_processing.schedule)

Rufus::Scheduler.singleton.every interval, VideoMailSchedulerHandler.new(interval), first_at: Time.now + 2.seconds
