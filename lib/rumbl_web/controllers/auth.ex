defmodule RumbleWeb.Auth do
  import Plug.Conn
  
  def init(opts), do: opts
  
  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    # &&演算子は、結果が真であれば右オペランドの値が返ってくる
    # nil,false以外の値は真して、扱われる
    # この場合、user_idが真なら、get_userの結果がuserに入る
    user = user_id && Rumble.Accounts.get_user(user_id)
    
    assign(conn, :current_user, user)
  end
  
end
