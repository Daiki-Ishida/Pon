module Admins::SessionsHelper
  def admin_log_in(admin)
    session[:admin_id] = admin.id
  end

  def logged_in_as_admin?
    !Admin.find_by(id: session[:admin_id]).nil?
  end
end
