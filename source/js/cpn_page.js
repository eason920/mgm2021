const cpn_item = {
	props: ['prop', 'req_src'],
	template: `
		<div class="giftbox-item">
			<div class="giftbox-imgouter">
				<div class="giftbox-img" :style="req_src"><img src="./2021/images/empty_item.png"></div>
			</div>
			<div class="giftbox-info">
				<div class="giftbox-title">{{prop.title}}</div>
				<div class="giftbox-pricebox">
					<div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">{{prop.Fcoin}} 點</div>
					<button class="giftbox-btn" @click='fnEmitClick'>兌換</button>
				</div>
			</div>
		</div>
	`,
	methods: {
		 fnEmitClick(){
			 this.$emit('connect_click');
		 },
		 fnStyle(){
			 return 'background-image: url(./2021/images/gifts/1.jpg)'
		 }
	}
};