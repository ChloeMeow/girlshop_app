const express = require('express');
const router = express();
const config = require('./config');
const base_url = "http://" + config.IP + ":" + config.PORT + "/images/goods/";

router.post("/",(req, res) =>{

    var hotGoods = {
       "code":"0",
       "message":"success",
       "data":[
        {
            "name":"法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙",
            "image": base_url +"1/001.jpg",
            "presentPrice": 98.88,
            "goodsId":"001",
            "oriPrice": 108.883,
        },{
           "name":"柔美而精致~高贵而优雅~圆领金银丝春季毛衣羊毛开衫女短款白外套",
           "image": base_url +"2/001.jpg",
           "presentPrice": 229.90,
           "goodsId":"002",
           "oriPrice": 320.99
        },{
            "name":"明星同款高端西服2019春装新款韩版英伦风短款格子小西装女外套潮",
            "image": base_url +"3/001.jpg",
            "presentPrice": 318.88,
            "goodsId":"003",
            "oriPrice": 388.88
        },{
            "name":"复古酮形机车进口編羊波衣真皮外器女E142",
            "image": base_url +"4/001.jpg",
            "presentPrice": 238.99,
            "goodsId":"004",
            "oriPrice": 248.99
        },{
            "name":"单排扣高發牛仔裤女春夏駕秋紧身弹力小脚拂組瘦百播网虹漫色长裤",
            "image": base_url +"5/001.jpg",
            "presentPrice": 588.99,
            "goodsId":"005",
            "oriPrice": 888.88,
        },{
            "name":"MIUCO女装夏季重工星星捷钻圖领短抽宽松显瘦百播T性上衣",
            "image": base_url +"6/001.jpg",
            "presentPrice": 1028.88,
            "goodsId":"006",
            "oriPrice": 1888.88,
        },{
            "name":"春夏一步裙包臀裙开叉弹力修身显瘦短裙黑色高腰职业半身裙",
            "image": base_url +"7/001.jpg",
            "presentPrice": 128.88,
            "goodsId":"007",
            "oriPrice": 88.88,
        },{
            "name":"夏季新款短袖圆领紧身小黑超短裙开叉包臀性感连衣裙夜店女装",
            "image": base_url +"8/001.jpg",
            "presentPrice": 928.88,
            "goodsId":"008",
            "oriPrice": 688.88,
        },
       ]
        
};
    res.send(hotGoods);
});
module.exports = router;