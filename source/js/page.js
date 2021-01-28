$(()=>{
	const ww = $(window).width();
	const nua = navigator.userAgent;
	if( /android | iphone/i.test(nua) || /ipad/i.test(nua) ){
		const w = $('.giftbox-item').outerWidth(true);
		const g = w - $('.giftbox-item').outerWidth();
		const l = $('.giftbox[data-category="1"]').find('.giftbox-item').length;
		const width = w * l + g;
		$('.giftbox[data-category="1"] .giftbox-scroller').css({width});
		console.log('is mb', w, l, g, width);
	}
});