const fnCountToSum = function (element, number, suffix, duration) {
	$({ count: parseInt(element.text().split("+")[0].replace(/\,/g, '')) }).animate({ count: number }, {
		duration: duration ? duration : 1000,
		easing: 'swing',
		step: function (now) {
			element.text((Math.floor(now) + suffix).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
		}
	});
};

$(()=>{
	$('.tabbox-item').click(function(){
		const tab = $(this).attr('data-tab');
		const left = $(this).index() * 25 + '%';
		$('.tabbox-active').css({left})
		//
		$('.tabbox-item, .contentbox-item').removeClass('active');
		$(this).addClass('active');
		//
		$('.contentbox').attr('data-tab', tab);
		//
		$('.contentbox-item').css('display', 'none');
		$('.contentbox-item[data-tab="'+ tab +'"]').css('display', 'block').addClass('active');
	});

	$('.tabbox-item:eq(0)').click();
	
	if( $(window).width() > 991 ){
		new PerfectScrollbar('.is-s1');
		new PerfectScrollbar('.is-s2');
		new PerfectScrollbar('.is-s3');
		new PerfectScrollbar('.is-s4');
	}else{
		// const $target = $('.contentbox-total');
		// const top = function(){
		// 	const h = $(window).height() - 60;
		// 	$target.css('top', h);
		// }
		// top();
		// $(window).resize(function(){
		// 	top();
		// })

		// --------------------------------
		$('.logobox-what').click(function(){
			$('.mgmcontent').addClass('is-open');
		});

		$('.coinbox-lb').click(function(){
			$('.mgmcontent').removeClass('is-open');
		});
	}
	
	// ==========================================
	// == COUNT v
	// ==========================================
	fnCountToSum( $('#countToSum') , 23500, '', 2000);
});