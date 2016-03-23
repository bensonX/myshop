;define(['jquery', 'backbone', 'touchSlider'], function ($, backbone, touchSlider) {
	var Views = backbone.View.extend({
		el: 'body',

		events: function () {

		},

		initialize: function() {
	    this.allClick();
	    this.render();
	    return this;
	  },
	  // 轮播加载touchSlider插件和跟轮播有关的事件
	  render: function() {
	    $(".main_visual").hover(function(){
				$("#btn_prev,#btn_next").fadeIn()
				},function(){
				$("#btn_prev,#btn_next").fadeOut()
			})

			$dragBln = false;
			$(".main_image").touchSlider({
				flexible : true,
				speed : 500,
				btn_prev : $("#btn_prev"),
				btn_next : $("#btn_next"),
				paging : $(".flicking_con a"),
				counter : function (e) {
					$(".flicking_con a").removeClass("on").eq(e.current-1).addClass("on");
				}
			});

			$(".main_image").bind("mousedown", function() {
				$dragBln = false;
			})

			$(".main_image").bind("dragstart", function() {
				$dragBln = true;
			})

			$(".main_image a").click(function() {
				if($dragBln) {
					return false;
				}
			})

			timer = setInterval(function() { 
				$("#btn_next").click();
			}, 5000);

			$(".main_visual").hover(function() {
				clearInterval(timer);
			}, function() {
				timer = setInterval(function() { 
					$("#btn_next").click();
				}, 5000);
			})

			$(".main_image").bind("touchstart", function() {
				clearInterval(timer);
			}).bind("touchend", function() {
				timer = setInterval(function() { 
					$("#btn_next").click();
				}, 5000);
			});
	  },
	  // 导航栏，返回顶部，事件
	  allClick: function () {
	  	var y=$('.nav').offset().top;
	    $(window).scroll(function(event) {	
	      var top=$(window).scrollTop()
	      if ( top>y) {
	        $('.nav').addClass('current');
	      }else{ $('.nav').removeClass('current');}
	    });


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

	  }

	});

	return Views;
})