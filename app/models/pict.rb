class Pict < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :user

  mount_uploader :picture, PictUploader
end
