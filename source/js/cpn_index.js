const cpn_list = {
	props: ['prop'],
	template: `
		<div class="contentbox-tip">
			<ol>
				<li>{{prop.title}}</li>
			</ol>
			<ol>
				<li>{{prop.cdate}}</li>
			</ol>
			<ol>
				<li>{{prop.Fcoin}}</li>
			</ol>
		</div>
	`
};

const cpn_2 = {
	props: ['prop', 'req_i'],
	template: `
		<div class="contentbox-tip">
			<ol>
				<li>{{req_i}}. {{prop.title}}</li>
			</ol>
		</div>
	`
}