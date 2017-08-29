import gulp from 'gulp';
import babel from 'gulp-babel';
import eslint from 'gulp-eslint';
import Cache from 'gulp-file-cache';

const cache = new Cache();

const config = {
  paths: [
    'src/es6/*.js',
  ],
  lintRules: {
    parser: 'babel-eslint',
    extends: 'airbnb'
  }
}

gulp.task('compile', () => {
  return gulp.src(config.paths)
    .pipe(cache.filter())
    .pipe(babel({
      presets: ['es2015']
    }))
    .pipe(cache.cache())
    .pipe(gulp.dest('dist'));
});

gulp.task('lint', () => gulp.src(config.paths)
  .pipe(eslint(config.lintRules))
  .pipe(eslint.format()));

gulp.task('lint:fix', () => {
  const fix = Object.assign({}, config.lintRules, { fix: true });
  return gulp.src(config.paths, { base: 'src/es6/' })
    .pipe(eslint(fix))
    .pipe(gulp.dest('src/es6/'))
    .pipe(eslint.format());
});

