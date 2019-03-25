install:
	bundle install

run:
	bundle exec jekyll serve --watch --incremental

.PHONY:
	install run
