var gulp = require('gulp');
var gutil = require('gulp-util');
var source = require('vinyl-source-stream');
var watchify = require('watchify');
var browserify = require('browserify');
var reactify = require('reactify');

gulp.task('browserify', function(){
  var b = browserify();
  b.add('./source/javascripts/_bundle.js');
  return b.bundle()
    .pipe(source('bundle.js'))
    .pipe(gulp.dest('./source/javascripts/'));
});
