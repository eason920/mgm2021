Vue.filter('filterBG', (str) => { return 'background-image: url(' + str + ')' });

const cpn_item = {
	props: ['prop', 'req_style', 'req_href'],
	template: `
		<a :href="req_href" class="giftbox-item">
			<div class="giftbox-imgouter">
				<div class="giftbox-img" :style="req_style"><img src="./2021/images/empty_item.png"></div>
			</div>
			<div class="giftbox-info">
				<div class="giftbox-title">{{prop.title}}</div>
				<div class="giftbox-pricebox">
					<div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">{{prop.Fcoin}} 點</div>
					<div class="giftbox-btn" @click='fnEmitClick'>兌換</div>
				</div>
			</div>
		</a>
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

// ==========================================
// == FADE SHOW v
// ==========================================
const cpn_fade = {
	props: ['prop', 'req_href', 'req_pic'],
	template: `
		<a class="fade-main-item"
			:href='req_href'
			:style="req_pic"
			@mouseover='emit_mouseover'
			@mouseout='emit_mouseout'
		>
			<div class="grid-subtitle">{{prop.subject}}</div>
			<div class="fade-btn">{{prop.button}}</div>
		</a>
	`,
	methods: {
		emit_mouseover(){
			this.$emit('connect_mouseover');
		},
		emit_mouseout(){
			this.$emit('connect_mouseout')
		}
	}
};

const cpn_fade_dot = {
	props: ['prop'],
	template: `
		<div 
			class="fade-dot-item"
			@mouseover='emit_mouseover(), emit_mouseover2()'
		></div>
	`,
	methods: {
		emit_mouseover(){
			this.$emit('connect_mouseover')
		},
		emit_mouseover2(){
			this.$emit('connect_mouseover2')
		},
	}
}