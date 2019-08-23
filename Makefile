default:
	jekyll build
	cd _site; \
	git add -A;\
	git commit -am 'Rebuilt site from subdir';\
	git push;
