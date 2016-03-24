// 所有header，footer的js动态

;$(function () {
  if ($('.nav').offset()) {
    var y = $('.nav').offset().top;
    $(window).scroll(function(event) {  
      var top=$(window).scrollTop()
      if ( top>y) {
        $('.nav').addClass('current');
      }else{ $('.nav').removeClass('current');}
    });
  }
  

  $('.nav ul li').hover(function() {
    $(this).find('.innav').stop().slideDown(300);
  }, function() {
    $(this).find('.innav').stop().slideUp(300);
  });
  // 返回顶部
  $('.fix .five').click(function(event) {
    $(this).parents('html,body').stop().animate({'scrollTop':'0'},300);
  });
  // 窗口固定区域开始
  $('.fix li').mouseenter(function(event) {
    $(this).find('.infix').stop().animate({'right':46}, 300)
  }).mouseleave(function(event) {
    $(this).find('.infix').stop().animate({'right':-120}, 300)
  });

  $('.news ul li:nth-child(4n)').css('margin-right', 0);
  $('.moods ul li:nth-child(4n)').css('margin-right', 0);

  // 人气商品开始
  $('.moods ul li').hover(function(){
    $(this).find('.top').stop().slideDown(500);
  },function(){
    $(this).find('.top').stop().slideUp(500);
  });

  // 图片区域初始化
    $('.list-images li').eq(1).css('margin-right', '0');
    $('.list-images li').eq(4).css('margin-right', '0');

    // 侧边栏悬停效果
    $('.list-nav li').mouseover(function() {
      var num=$(this).index();
      $(this).find('.list-twoCategory').show();
      $(this).find('.list-twoCategory ul li').eq(num-1).addClass('current').siblings().removeClass('current');
    }).mouseout(function() {
      var num=$(this).index();
      $(this).find('.list-twoCategory').hide();
    });

    // 购买导航开始
    $('.goods-nav span').hover(function() {
      $(this).find('.goods-opt').stop().slideDown(300);
    }, function() {
      $(this).find('.goods-opt').stop().slideUp(300);
    });


    $('.goods-opt a').click(function() {
      var text= $(this).html();
      $(this).parents('span').html(text);
    });

});