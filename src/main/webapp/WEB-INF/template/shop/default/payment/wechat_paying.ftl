[#escape x as x?html]
<!DOCTYPE html>
<html lang="en">
    <head>
		<meta charset = "utf-8" />
		<title>${message("shop.order.checkout")}[#if showPowered]买德好[/#if]</title>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta name="keywords" content="test" />
		<meta name="description" content="买德好专注打造国内首家德国跨境精品聚集地，只将最具品质及品味的德国正品引入国人生活。涵盖生活多方面的产品体系，带来真正一站式的购物便捷体验。独具特色的知识性模块形式，让你无限贴近德式生活" />
		<link href="favicon.ico" rel="icon" type="image/x-icon" />
		<link type="text/css" rel="stylesheet" href="${base}/resources/shop/${theme}/css_mdh/main.css" />
		<script src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
		<script src = "${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
		<script src="${base}/resources/shop/${theme}/js_mdh/main/views/buy.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
		
		<script type="text/javascript">
		var timer1;
		/* 查询是否支付成功 */
		function payResult() {
			$.get("${base}/payment/payResultSearch/${out_trade_no}.jhtml", function(data) {
			    console.log("lsu into timer: type is: " + data.result.type + "  content is: " + data.result.content);
			    console.log(data);
				if (data.result.type == "SUCCESS") {
				    console.log("lsu pay success, will kill timer!");
					$("#paying").html("Hello: <b>PAY SUCCESS</b>!");
					//stop the timer;
					clearInterval(timer1);
				}
				else {
				    console.log("lsu pay failed");
					$("#paying").html("the check result is : " + data.result.content );
				}
			});
		}
		$(function() {
			/* 每隔4秒查一次 */
			timer1 = window.setInterval("payResult()", 4000);
		});
		</script>
	</head>
	
    <body>
		[#include "/shop/${theme}/include/header_mdh.ftl" /]	

		
		<div  id = "paying" class = "paying">
		<h> is ....</h>	
		</div>
		
		<div>		
		<h> out_trade_no is:  ${out_trade_no}</h>
		</div>
		
		<div>		
		<h> return_code is(success or failed):  ${return_code}</h>
		</div>
		
		<div>
	    <img src="${base}/${code}"> url is: ${base}/${code} </img>
	    </div>
		
		[#include "/shop/${theme}/include/footer_mdh.ftl" /]
    </body>	
    

</html>
[/#escape]		
		