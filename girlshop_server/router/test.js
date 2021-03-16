const express = require('express');
const router = express();
const config = require('./config');
const bae_url = "http://" + config.IP + ":" + config.PORT + "images/banner/";

router.get("/",(req, res) =>{
    var id = req.query.id
    console.log("传递过来的参数测试:id = " + id);
    var data = {
        "code":"0",
        "message":"success",
        "data":[
            {
                "images":bae_url + "01.png",
            },
            {
                "images":bae_url + "02.png",
            },
            {
                "images":bae_url + "03.png",
            }
        ]
    };
    res.send(data);
});
module.exports = router;