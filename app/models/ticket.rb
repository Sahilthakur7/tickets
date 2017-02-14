class Ticket < ActiveRecord::Base

  belongs_to :project
  belongs_to :author, class_name: "User"
  belongs_to :state
  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags, uniq: true
  attr_accessor :tag_names
  accepts_nested_attributes_for :attachments, reject_if: :all_blank
  validates :name, presence: true
  validates :description, presence: true


  def tag_names=(names)
      @tag_names = names
      names.split.each do |name|
          self.tags << Tag.find_or_initialize_by(name: name)
      end
  end
end
