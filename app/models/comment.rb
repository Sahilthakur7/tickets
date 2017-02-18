class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :author, class_name: "User"
  belongs_to :state

  validates :text, presence: true

  delegate :project, to: :ticket

  scope :persisted, lambda { where.not(id:nil) }

  after_create :set_ticket_state
  after_create :author_watches_ticket
  
private
  def set_ticket_state
      ticket.state = state
      ticket.save
  end

  def author_watches_ticket
      if author.present? && !ticket.watchers.include?(author)
          ticket.watchers << author
      end
  end
end
