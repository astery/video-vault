class Video < ActiveRecord::Base
  belongs_to :user
  has_attached_file :file
  validates_attachment_content_type :file, :content_type => /\Avideo\/.*\Z/

  scope :need_to_be_scheduled_for, -> (interval) { where(show_at: Time.now..(Time.now + interval)) }
end
