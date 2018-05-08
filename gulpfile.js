var gulp = require('gulp');
var notify = require("gulp-notify");
var coffee = require("gulp-coffee");
var jshint = require('gulp-jshint');
var uglify = require('gulp-uglify');
var minifyCSS = require('gulp-minify-css');
var concat = require('gulp-concat');
var livereload = require('gulp-livereload');
var watch = require('gulp-watch');
var sass = require('gulp-scss');
var plumber = require('gulp-plumber');



var paths = {
	jsScripts: [
					'./public/assets/js/lib/jquery-2.1.3.min.js',
					'./public/assets/js/lib/angular.min.js',
					'./public/assets/js/lib/bootstrap.min.js',
					'./public/assets/js/lib/fontawesome.js',
					'./public/assets/js/src/*.js'
				],
	cssStyles: [
					'./public/assets/css/lib/bootstrap.min.css',
					'./public/assets/css/lib/fontawesome-all.min.css',
					'./public/assets/css/lib/reboot.css',
					'./public/assets/css/src/*.css'
				]
};

gulp.task('watch', function () {
    gulp.watch('./public/assets/coffee/*.coffee', ['coffee', 'scripts']);
    gulp.watch('./public/assets/scss/*.scss', ['sass', 'styles']);
});



gulp.task('scripts', function(){
	return gulp.src(paths.jsScripts)
	    .pipe(concat('all.min.js'))
	    .pipe(gulp.dest('./public/assets/js/'))
	    .pipe(notify("Compiled JS"))
	    .pipe(livereload());
});

gulp.task('coffee', function () {
    gulp.src('./public/assets/coffee/*.coffee')
    	.pipe(plumber())
    	.pipe(coffee({bare: true}))
    	.pipe(gulp.dest('./public/assets/js/src'));
});



gulp.task('sass', function () {
    gulp.src('./public/assets/scss/*.scss')
		.pipe(plumber())
    	.pipe(sass())
    	.pipe(gulp.dest('./public/assets/css/src'));
});

gulp.task('styles', function(){
	return gulp.src(paths.cssStyles)
	    .pipe(concat('all.min.css'))
	    .pipe(gulp.dest('./public/assets/css/'))
	    .pipe(notify("Compiled CSS"))
	    .pipe(livereload());
});

gulp.task('default', ['styles', 'scripts', 'watch']);
