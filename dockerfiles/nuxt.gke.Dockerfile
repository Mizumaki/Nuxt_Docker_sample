# ベースとなるイメージを取得
FROM node:8-alpine
# MAINTAINER は 1.13v 以降非推奨になった
LABEL  maintainer "Ryota Mizumaki"

# 環境変数を設定
ENV LANG C.UTF-8

# yarnをグローバルにインストール
RUN npm i -g npm yarn && \
  chmod +x /usr/local/lib/node_modules/yarn/bin/yarn.js && \
  yarn global upgrade --latest

# ディレクトリを作成するコマンドを実行
RUN mkdir nuxt

# ADD と COPY の違いは以下を参照
# https://qiita.com/hihihiroro/items/0956326d6731bc927166
# だが、COPY のほうが望ましいと公式には記載がある
# http://docs.docker.jp/engine/userguide/eng-image/dockerfile_best-practice.html#add-copy
COPY ./nuxt /nuxt

# 作業ディレクトリを変更
WORKDIR /nuxt
# 以下の命令は /nuxt 配下で行われる

RUN yarn && yarn build

# コンテナ実行時にコンテナ内で開けるポートを指定
# 実行時に、このポート番号をホストのポートと繋げることでアクセスができる
EXPOSE 3000

# 0.0.0.0であることが重要
# デフォルトのlocalhostだと、内部で閉じて上手くいかない
# https://keens.github.io/blog/2016/02/24/bind_addressnoimigayouyakuwakatta/
ENV HOST 0.0.0.0