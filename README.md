# Rumbl

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).


## virtual display

```
sudo Xvfb :1 -screen 0 1920x1080x24+32 &
sudo startxfce4 &
sudo x11vnc -display :1 &
sudo  /opt/novnc/utils/novnc_proxy  --vnc localhost:5900 &
```

6080ポートで待機しているnovncを開いて接続する。

メモ
* xvfb（仮想ディスプレイ）、startxce4(デスクトップ環境)、x11vnc(VNCサーバ)、novnc(VNCクライアント)の順で起動する
* DISPLYを0番ではなく1番にするとうまくいった。（おそらくstartxfce4のデフォルト番号、これを変えれば0でもOKなはずだけど、手間なので1が楽）


## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
