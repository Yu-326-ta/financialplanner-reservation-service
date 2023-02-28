module PlannersSessionsHelper

  # 渡されたユーザーでログインする
  def log_in_planner(planner)
    session[:planner_id] = planner.id
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember(planner)
    planner.remember
    cookies.permanent.encrypted[:planner_id] = planner.id
    cookies.permanent[:remember_token] = planner.remember_token
  end

  # 現在ログイン中のユーザーを返す（いる場合）
  def current_planner
    if (planner_id = session[:planner_id])
      @current_planner ||= Planner.find_by(id: planner_id)
    elsif (planner_id = cookies.encrypted[:planner_id])
      planner = Planner.find_by(id: planner_id)
      if planner && planner.authenticated?(cookies[:remember_token])
        log_in_planner planner
        @current_planner = planner
      end
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in_planner?
    !current_planner.nil?
  end

  # 永続的セッションを破棄する
  def forget(planner)
    planner.forget
    cookies.delete(:planner_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out_planner
    forget(current_planner)
    reset_session
    @current_planner = nil
  end
end
