const express = require('express');
const path = require('path');
const app = express();

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
app.use("/getHotGoods",require("./router/hotgoods"));

const port = process.env.PORT || 3000;

app.listen(port,()=>{
    console.log(`server running (http://localhost:${port})`);
});
module.exports = app;

