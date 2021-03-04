$(()=>{
	console.log('got jq');
	const zipcode = [];

	$.ajax({
		url: "./api/zipcode_gov.json",
		type: "GET",
		contentType: "application/json",
		success(res){
			const max = res.length - 1;

			res.forEach(function(item, i){
				// const idx = zipcode.findIndex(b => b.county == item.COUNTYNAME);
				const idx = zipcode.findIndex(function(b){
					return b.county == item.COUNTYNAME;
				});

				switch(true){
					case idx == -1:
						const obj = {county: item.COUNTYNAME,  town: [{town: item.TOWNNAME, code: item.ZIPCODE}]}
						zipcode.push(obj);
						break;
					case idx >= 0:
						const town = {town: item.TOWNNAME, code: item.ZIPCODE};
						zipcode[idx].town.push(town);
					default:
				}

				if( i == max ){
					console.log('end ', JSON.stringify(zipcode));
				}
			});
		}
	});


});