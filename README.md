# README
以下の手順でRailsサーバー立ち上げることができます。

1. `git clone https://github.com/worldwidepark/gassiper_rails.git`
2. `cd gassiper_rails`
3. `docker-compose run web rails db:create && docker-compose run web rails db:migrate` 
4. `docker-compose up`
