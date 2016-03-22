$(function () {
  'use strict';

  // 轮播图开始
  var oli=$('.banner ul li:first()').clone(true);
  $('.banner ul').append(oli);
  var time;
    var myleft;
    var num=0;
    var num1=0;
  function next(){
      num++;
      if (num>2) {
        num=0
      };
      $('.banner ol li').eq(num).addClass('current').siblings().removeClass('current');

      num1++;
      if (num1>2) {
        $('.banner ul').css('margin-left', 0);
        num1=1
      };

       myleft=num1*-1100;

      $('.banner ul').stop().animate({'margin-left': myleft}, 500);

    }

    time=setInterval(next,3000);

    $('.banner').hover(function() {
      clearInterval(time);
      $('.banner button').show();
    }, function() {
      clearInterval(time);
      time=setInterval(next,3000);
      $('.banner button').hide();
    });

    $('.banner ol li').hover(function(event) {
      var s=$(this).index()
      myleft=s*-1100

      $(this).addClass('current').siblings().removeClass('current');
      $('.banner ul').stop().animate({'margin-left':myleft}, 500)
      num=num1=s;
    });
    $('.right').click(next);
    $('.left').click(function(event) {
        num1--;
        if (num1<0) {
          $('.inbanner').css('margin-left',-3300);
          num1=2;
        };
        myleft=num1*-1100;

        $('.inbanner').stop().animate({'margin-left':myleft}, 500);

        num--;
        if (num<0) {
          num=2;
        };

        $('ol li').eq(num).addClass('current').siblings().removeClass('current');
      });

    // 导航栏开始
      var y=$('.nav').offset().top;
    $(window).scroll(function(event) {
      var top=$(window).scrollTop()
      if ( top>y) {
        $('.nav').addClass('current');
      }else{ $('.nav').removeClass('current');}
    });
    $('.nav ul li').hover(function() {
      $(this).find('.innav').show();
    }, function() {
      $(this).find('.innav').hide();
    });
    // 返回顶部
    $('.fix .five').click(function(event) {
      $(window).scrollTop(0);
    });
    // 窗口固定区域开始
    $('.fix ul li').mouseenter(function(event) {
      var number=$(this).index();
      $('.fix ol li').eq(number).stop().animate({'right':46}, 300)
    }).mouseleave(function(event) {
      var number=$(this).index();
      $('.fix ol li').eq(number).stop().animate({'right':-120}, 300)
    });
})