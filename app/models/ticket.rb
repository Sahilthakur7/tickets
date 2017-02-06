class Ticket < ActiveRecord::Base

  belongs_to :project
  belongs_to :author, class_name: "User"
  validates :name, presence: true
  validates :description, presence: true
  mount_uploader :attachment, AttachmentUploader
end
