module ClientsSessionsHelper

  # 渡されたユーザーでログインする
  def log_in_client(client)
    session[:client_id] = client.id
  end

  # 現在ログイン中のユーザーを返す（いる場合）
  def current_client
    if session[:client_id]
      @current_client ||= Client.find_by(id: session[:client_id])
    end
  end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in_client?
    !current_client.nil?
  end
end
