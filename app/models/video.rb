class Video < ActiveRecord::Base
  belongs_to :user
  has_attached_file :file, :styles => {
    main: { :geometry => "400x300", :format => 'mp4', :streaming => true },
    thumb: { :geometry => "100x100#", :format => 'jpg', :time => 5 }
  }, processors: [:ffmpeg, :qtfaststart]
  validates_attachment_content_type :file, :content_type => /\Avideo\/.*\Z/
  process_in_background :file

  scope :need_to_be_scheduled_for, -> (interval) { where(show_at: Time.now..(Time.now + interval)) }
end
