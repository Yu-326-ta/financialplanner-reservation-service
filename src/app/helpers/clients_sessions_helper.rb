module ClientsSessionsHelper

  # 渡されたユーザーでログインする
  def log_in_client(client)
    session[:client_id] = client.id
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember(client)
    client.remember
    cookies.permanent.encrypted[:client_id] = client.id
    cookies.permanent[:remember_token] = client.remember_token
  end

  # 記憶トークンcookieに対応するユーザーを返す
  def current_client
    if (client_id = session[:client_id])
      @current_client ||= Client.find_by(id: client_id)
    elsif (client_id = cookies.encrypted[:client_id])
      client = Client.find_by(id: client_id)
      if client && client.authenticated?(cookies[:remember_token])
        log_in_client client
        @current_client = client
      end
    end
  end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in_client?
    !current_client.nil?
  end

  # 永続的セッションを破棄する
  def forget(client)
    client.forget
    cookies.delete(:client_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out_client
    forget(current_client)
    reset_session
    @current_client = nil 
  end
end
