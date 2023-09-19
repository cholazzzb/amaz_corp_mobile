setup:
	@flutter pub get

fix: 
	@dart fix

dev:
	@flutter run

build-abb:
	@flutter build appbundle

build-apk:
	@flutter build apk

watch:
	@dart run build_runner watch -d

clean:
	@flutter pub cache clean