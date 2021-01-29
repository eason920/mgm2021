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
		}
	}else{
		$(window).on('load resize', function(){ fnImgOuterHeight() });
	};

	// --------------------------------
	$('.giftbox-btn').click(function(){
		$('.mgmlb').fadeIn();
	});

	$('.mgmlb').click(function(){
		$(this).fadeOut();
	})
});