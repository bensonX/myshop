
<ul class="personal-nav fl">
	<li [#if indexLeft==1]class="current" [/#if]><a href="${base}/member/index.jhtml">我的信息</a></li>
	<li [#if indexLeft==2]class="current" [/#if]><a href="${base}/member/order/list.jhtml">我的订单</a></li>
	<li [#if indexLeft==3]class="current" [/#if]><a href="${base}/member/favorite/list.jhtml">我的收藏</a></li>
	<li [#if indexLeft==4]class="current" [/#if]><a href="${base}/member/receiver/list.jhtml">收件地址</a></li>
	<li [#if indexLeft==5]class="current" [/#if]><a href="${base}/member/password/securityCenter.jhtml">安全中心</a></li>
</ul>
