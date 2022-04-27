# README

```
dockerの課題をclone。
```
```
# docker-compose run web bash
```

```
ERROR: Service 'web' failed to build : The command '/bin/sh -c bundle install' returned a non-zero code: 18
```
- 上記のエラー発生のため、dockerfileを修正後再実行。
```
# docker-compose run web bash
```
```
# rails new . -force --database=mysql --webpacker
```

