module SessionsHelper
  
  #ログイン中のユーザを取得
  def current_user
    #本メソッドは、@current_userを返す
    
    # ||= とは左の値がfalseまたはnilの場合に、右の値を代入する
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    # current_userが存在するか確認
    
    # !!は右の値が存在する場合はtrue、nilの場合はfalse
    !!current_user
  end
  
  def store_location
    # リクエストがGETの場合、リクエストのURLを代入
    session[:forwarding_url] = request.url if request.get?
  end
end