
index.js: index.ls lang/C.js
	echo '#!/usr/bin/env node' > $@
	lsc -p -c $<  >> $@
	chmod +x $@

lang/%.js: lang/%.ls
	lsc -c -p $< >> $@

clean:
	rm index.js
