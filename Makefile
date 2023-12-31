include .env

#Построение релизной версии пользовательского приложния
buildWebRelease: build/web/index.html

build/web/index.html:
			flutter build web \
			--release \
			-t lib/main_web.dart \
			--base-href /box/


.PHONY: cleanAll
cleanAll:
			flutter clean

.PHONY: upload
upload: build/web/index.html
	scp -r -P $(UPLOAD_PORT) build/web/ root@$(UPLOAD_HOST):/var/www/web/box
