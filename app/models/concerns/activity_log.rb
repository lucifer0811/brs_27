module ActivityLog
  extend ActiveSupport::Concern

  def create_activity onwer_id, target_id, target_type, action
    Activity.create(user_id: onwer_id, target_id: target_id,
      target_type: target_type, action_type: action)
  end
end

