const base_url = 'http://192.168.0.1:8080/';
//安卓模拟器建议改为192.168把它写死，否则出现连续不上的情况
const servicePath = {
  'homePageContent': base_url + 'getHomePageContent', //首页数据
  'homeHotGoods': base_url + 'homeHotGoods', //火爆专区
  'homeCategory': base_url + 'homeCategory', //商品类别信息
  'homeCategoryGoods': base_url + 'homeCategoryGoods', //商品分类的商品列表
  'homeGoodDetail': base_url + 'homeGoodDetail', //商品详细信息
};
