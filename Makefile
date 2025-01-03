setup:
	@flutter pub get

fix: 
	@dart fix

dev:
	@flutter run

build-aab:
	@flutter build appbundle

build-apk:
	@flutter build apk

watch:
	@dart run build_runner watch -d

upgrade:
	@flutter pub upgrade 
	
clean:
	#[[Deleting previous abb file and update local.properties versionCode]]
	@flutter clean

clean-cache:
	@flutter pub cache clean

check-dep:
	@flutter pub outdated

get-ip:
	@ipconfig getifaddr en0