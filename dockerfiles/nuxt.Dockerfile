# ベースとなるイメージを取得
# FROM <イメージ>:<タグ> タグを設定しないと、デフォルトでlatestが選択される
FROM node
# MAINTAINER は 1.13v 以降非推奨になった
LABEL  maintainer "Ryota Mizumaki"

# 環境変数を設定
ENV LANG C.UTF-8

# ディレクトリを作成するコマンドを実行
RUN mkdir nuxt

# Dockerfile内でVolumeを示しているが、
# これは`docker run`実行時に示すのでもよい
# （というか、どのみちホストのファイルを載せるには実行時にも示す必要がある）
# VOLUME ["/nuxt"]

# ADD と COPY の違いは以下を参照
# https://qiita.com/hihihiroro/items/0956326d6731bc927166
# だが、COPY のほうが望ましいと公式には記載がある
# http://docs.docker.jp/engine/userguide/eng-image/dockerfile_best-practice.html#add-copy
# COPY ./nuxt /nuxt

# 作業ディレクトリを変更
WORKDIR /nuxt
# 以下の命令は /nuxt 配下で行われる

# コンテナ実行時にコンテナ内で開けるポートを指定
# 実行時に、このポート番号をホストのポートと繋げることでアクセスができる
EXPOSE 3000

ENV NODE_ENV development
# 0.0.0.0であることが重要
# デフォルトのlocalhostだと、内部で閉じて上手くいかない
# https://keens.github.io/blog/2016/02/24/bind_addressnoimigayouyakuwakatta/
ENV HOST 0.0.0.0

# コンテナ起動時に実行するコマンドを指定。イメージ構築時には使用されない
# １つの Dockerfile の中に１つしか CMD は設置することができない（というか１つしか実行されない）
# 複数実行させたい場合は、シェルスクリプトを書く方法もある
# このコマンドは、docker-compose を経由した場合は無視される
CMD ["yarn", "docker"]