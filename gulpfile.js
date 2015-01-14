var gulp = require('gulp');
var gutil = require('gulp-util');
var source = require('vinyl-source-stream');
var watchify = require('watchify');
var browserify = require('browserify');
var reactify = require('reactify');

gulp.task('watch', function() {
  watchify.args.fullPaths = false;
  var bundler = watchify(browserify('./source/javascripts/_bundle.js', watchify.args));

  bundler.on('update', rebundle);

  function rebundle() {
    return bundler.bundle()
      .on('error', gutil.log.bind(gutil, 'Browserify Error'))
      .pipe(source('bundle.js'))
      .pipe(gulp.dest('./source/javascripts/'));
  }

  return rebundle();
});

gulp.task('browserify', function(){
  var b = browserify();
  b.add('./source/javascripts/_bundle.js');
  return b.bundle()
    .pipe(source('bundle.js'))
    .pipe(gulp.dest('./source/javascripts/'));
});
