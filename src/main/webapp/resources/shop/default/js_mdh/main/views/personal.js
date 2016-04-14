/*
* @Author: maidehao
* @Date:   2016-04-12 16:11:46
* @Last Modified by:   maidehao
* @Last Modified time: 2016-04-13 12:21:26
*/

'use strict';


$(function() {
    // 收藏列表
  $('.personal-collect ul li').hover(function() {
    $(this).find('.top').stop().fadeIn(400);
  }, function() {
    $(this).find('.top').stop().fadeOut(400);
  });
  
  $('.personal-collect ul li:nth-child(3n)').css('margin-right',0);
});
