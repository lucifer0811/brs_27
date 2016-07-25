class BookStatus < ActiveRecord::Base
  include ActivityLog
  belongs_to :user
  belongs_to :book
  enum reading_status: [ :unread, :read, :reading ]
  after_save :create_status_activty

  scope :correct_user, -> user_id {where user_id: user_id}
  scope :filter_favorite, -> {where is_favorite: true}

  private
  def create_status_activty
      create_activity(user_id, book_id, Activity.target_types[:book_target],
        Activity.action_types[which_changed]) unless which_changed.nil?
  end

  def which_changed
    if self.is_favorite_changed? && self.is_favorite
      :favorite
    elsif self.reading_status_changed?
      self.reading_status unless self.unread?
    end
  end

end
