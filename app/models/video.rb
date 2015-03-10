class Video < ActiveRecord::Base
  belongs_to :user
  has_attached_file :file, :styles => {
    main: { :geometry => "640x480", :format => 'mp4', :streaming => true },
    thumb: { :geometry => "120x90#", :format => 'jpg', :time => 5 }
  }, processors: [:ffmpeg, :qtfaststart]
  validates_attachment_content_type :file, :content_type => /\Avideo\/.*\Z/
  process_in_background :file

  validates :title, :show_at, :file, presence: true

  scope :need_to_be_scheduled_for, -> (interval) { where(show_at: Time.now..(Time.now + interval)) }
end
