defmodule RumblWeb.Auth do
  import Plug.Conn

  # コンパイル時にオプションを指定する
  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    # &&演算子は、結果が真であれば右オペランドの値が返ってくる
    # nil,false以外の値は真して、扱われる
    # この場合、user_idが真なら、get_userの結果がuserに入る
    user = user_id && Rumbl.Accounts.get_user(user_id)

    assign(conn, :current_user, user)
  end
  
  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session([renew: true])
  end

end
