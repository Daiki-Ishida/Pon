module Admins::SessionsHelper
  def   admin_log_in(admin)
    session[:admin_id] = admin.id
  end
end
