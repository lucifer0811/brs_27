class BookStatus < ActiveRecord::Base
  include ActivityLog
  belongs_to :user
  belongs_to :book
  enum reading_status: [ :unread, :read, :reading ]
  after_save :create_status_activty

  private
  def create_status_activty
    create_activity user_id, book_id, Activity.target_types[:book_target],
      Activity.action_types[which_changed]
  end

  def which_changed
    if self.is_favorite_changed? && self.is_favorite
      :favorite
    elsif self.reading_status_changed?
      self.reading_status
    end
  end

end
