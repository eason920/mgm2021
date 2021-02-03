var gulp = require('gulp'),
	$ = require('gulp-load-plugins')(),
	autoprefixer = require('autoprefixer'),
	minimist = require('minimist');
// ====================================
// == ENV
// ====================================
var envOptions = {
	string: 'env',
	default: {env: 'dev'}
}
var options = minimist(process.argv.slice(2), envOptions);
console.log(options);

// ====================================
// == HTML
// ====================================
gulp.task('pug', function(){
	gulp.src('./source/*.pug')
		.pipe($.plumber())
		.pipe($.data(function(){
			var page = require('./source/data/page.json'),
				source = {
					page
				}
			return source;
		}))
		.pipe($.pug({
			pretty: true
		}))
		.pipe(gulp.dest('./public/'));
});




// gulp.task('pug', ()=>
// 	gulp.src('./source/*.pug')
// 	.pipe($.plumber())
// 	.pipe($.data(function(){
// 		var header = require('./source/data/header.json'),
// 			page = require('./source/data/page.json'),
// 			source = {
// 				'header': header,
// 				'page': page
// 			}
// 		return source;
// 	}))
// 	.pipe($.pug({
// 		pretty: true
// 	}))
// 	.pipe($.rename(function(path){
// 		path.extname = '.php'
// 	}))
// 	.pipe(gulp.dest('./public'))
// )





gulp.task('email', function(){
	gulp.src('./source/email/*.pug')
		.pipe($.plumber())
		.pipe($.pug({
			pretty: true
		}))
		.pipe(gulp.dest('./public/email'))
});

gulp.task('tmp_module', function(){
	gulp.src('./source/tmp_module/*.pug')
		.pipe($.plumber())
		.pipe($.pug({
			pretty: true
		}))
		.pipe(gulp.dest('./public/tmp_module/'))
});

// ====================================
// == STYLE SHEET
// ====================================
gulp.task('css', function(){
	gulp.src('./source/css/**/*.css')
		.pipe($.postcss([autoprefixer()]))
		.pipe($.cleanCss())
		.pipe($.rename(function(path){
			path.basename += '.min'
		}))
		.pipe(gulp.dest('./public/css/'));
	gulp.src('./source/css/**/*.css')
		.pipe(gulp.dest('./public/css/'));
	gulp.src('./source/css/**/*.map')
		.pipe(gulp.dest('./public/css/'));
});

// ====================================
// == JAVASCRIPT
// ====================================
gulp.task('js', function(){
	gulp.src('./source/js/**/*.js')
		// .pipe($.babel({
		// 	presets: ['@babel/env']
		// }))
		// .pipe($.uglify({
		// 	compress: {
		// 		drop_console: true
		// 	}
		// }))
		// .pipe($.rename(function(path){
		// 	path.basename += '.min'
		// }))
		// .pipe(gulp.dest('./public/js/'));
	gulp.src('source/js/**/*.js')
		.pipe(gulp.dest('./public/js/'));
});

gulp.task('tmp_js', function(){
	gulp.src('./.tmp/assets/tmp/*.js')
		.pipe(gulp.dest('./public/assets/tmp/'))
});

// ====================================
// == IMAGES
// ====================================
gulp.task('img', function(){
	gulp.src('./source/images/**/*')
		.pipe($.if(options.env === 'prod', $.imagemin({
			optimizationLevel: 5, //類型：Number 預設：3 取值範圍：0-7（優化等級）
			progressive: true, //類型：Boolean 預設：false 無損壓縮jpg圖片
			interlaced: true, //類型：Boolean 預設：false 隔行掃描gif進行渲染
			multipass: true //類型：Boolean 預設：false 多次優化svg直到完全優化
		})))
		.pipe(gulp.dest('./public/images/'));
})

// ====================================
// == DATA
// ====================================
gulp.task('data', function(){
	gulp.src('./source/data/**/*.json')
		.pipe(gulp.dest('./public/data/'));
});

// ====================================
// == SYSTEM
// ====================================
gulp.task('cleanTwo', function (){
	return gulp.src(['./public/', './node_modules'], {read: false})
	// return gulp.src('./public/', {read: false})
		.pipe($.clean());
})

gulp.task('clean', function(){
	return gulp.src('./public', {read: false})
		.pipe($.clean());
})

gulp.task('build', function(){
	gulp.src('./.tmp/assets/plugins/**')
		.pipe(gulp.dest('./public/assets/plugins/'));
	gulp.src('./source/data/*.json')
		.pipe(gulp.dest('./public/data/'))
})


const mission = function(){
	gulp.watch('./source/css/**/*.css', ['css']);
	gulp.watch('./source/partials/**/*.pug', ['pug']);
	gulp.watch('./source/email/*.pug', ['email']);
	gulp.watch('./source/tmp_module/*.pug', ['tmp_module']);
	gulp.watch('./source/js/**/*.js', ['js']);
	gulp.watch('./.tmp/assets/tmp/*.js', ['tmp_js'])
	gulp.watch('./source/images/**/*', ['img']);
	gulp.watch('./source/data/*.json', ['data']);
}
gulp.task('default', ['pug', 'email', 'tmp_module', 'css', 'js', 'tmp_js', 'img', 'data'], function(){
	gulp.watch('./source/*.pug', ['pug']);
	mission();
});

gulp.task('vue', ['email', 'tmp_module', 'css', 'js', 'tmp_js', 'img', 'data'], function () {
	mission();
});