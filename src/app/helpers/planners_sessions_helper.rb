module PlannersSessionsHelper
  # 渡されたユーザーでログインする
  def log_in_planner(planner)
    session[:planner_id] = planner.id
  end

  # 現在ログイン中のユーザーを返す（いる場合）
  def current_planner
    if session[:planner_id]
      @current_planner ||= Planner.find_by(id: session[:planner_id])
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in_planner?
    !current_planner.nil?
  end
end
