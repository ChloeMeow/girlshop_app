const express = require('express');
const path = require('path');
const app = express();
// 引入config配置
const config = require('./router/config.js');

app.use(express.static(path.resolve(__dirname, 'public')));

app.use((req,res,next) => {
  const proxy = req.query.proxy;
  if (proxy) {
    req.header.cookie += `__proxy__${proxy}`;
  }
  next();
});

//获取数据，路由到不同的数据监控
app.use("/getTestData",require("./router/test"));
app.use("/getHomePageContent",require("./router/home_page_content"));

// 使用config中的配置端口
const port = config.PORT || 8080;

app.listen(port,()=>{
    console.log(`服务运行在 ${port} 端口`);
});
module.exports = app;

