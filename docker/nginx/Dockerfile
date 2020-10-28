FROM nginx:1.15.8

# インクルード用のディレクトリ内を削除
RUN rm -f /etc/nginx/conf.d/*

# Nginxの設定ファイルをコンテナにコピー
COPY /docker/nginx/nginx.conf /etc/nginx/conf.d/cook-with.conf

# 画像などのpublicファイルはnginxに配置
RUN mkdir -p /cook-with/public
COPY /public /cook-with/public

# ビルド完了後にNginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
