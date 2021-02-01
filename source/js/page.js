let deviceClass;

const fnImgOuterHeight = function(){
	setTimeout(()=>{
		const height = $('.giftbox-img').height();
		$('.giftbox-imgouter').css({height});
	}, 100);
};

$(()=>{
	const ww = $(window).width();
	const nua = navigator.userAgent;
	
	if( /android | iphone/i.test(nua) || /ipad/i.test(nua) ){
		const w = $('.giftbox-item').outerWidth(true);
		const g = w - $('.giftbox-item').outerWidth();
		for( i=1; i<=3; i++){
			const l = $('.giftbox[data-category="'+i+'"]').find('.giftbox-item').length - $('.giftbox[data-category="'+i+'"]').find('.is-empty').length;
			const width = w * l + g;
			$('.giftbox[data-category="'+i+'"] .giftbox-scroller').css({width});
			console.log('is mb', w, l, g, width);
			//
			deviceClass = 'is-mb-open';
		};
		
		console.log();
	}else{
		$(window).on('load resize', function(){ fnImgOuterHeight() });

		new PerfectScrollbar('.mgmlb-info');
		//
		deviceClass = 'is-pc-open';
	};
	
	// --------------------------------
	$('.giftbox-btn').click(function(){
		$('.mgmlb').fadeIn().addClass(deviceClass);
		$('html').css('overflow', 'hidden');
		//
	});

	$('.mgmlb').click(function(){
		const time = 300
		$(this).fadeOut(time);
		$('html').removeAttr('style');
		//
		setTimeout(()=>{
			$('.mgmlb').removeClass(deviceClass);
		}, time);
	});

	// $('.giftbox-btn').click();
});