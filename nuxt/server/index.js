// 作成にあたり、以下を参照
// https://ja.nuxtjs.org/api/nuxt-render/

const express = require("express");
const { Nuxt, Builder } = require("nuxt");

const app = express();

const host = process.env.HOST || "127.0.0.1";
const port = process.env.PORT || 3000;

// Nuxt.js をオプションとともにインスタンス化する
const config = require('../nuxt.config.js');
const nuxt = new Nuxt(config);

const isProd = process.env.NODE_ENV === "production";
config.dev = !isProd;

// すべてのルートを Nuxt.js でレンダリングする
app.use(nuxt.render);

const listen = () => {
  // サーバーを Listen する
  app.listen(port, host);
  console.log(`Yay! Server listening on http://${host}:${port}`);
};

// ホットリローディングする開発モードのときのみビルドする
if (config.dev) {
  console.log("This is dev mode");
  new Builder(nuxt).build().then(() => {
    console.log('build process is done!!');
    listen();
  })
} else {
  listen();
}