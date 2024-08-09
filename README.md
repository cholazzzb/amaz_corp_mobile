# amaz_corp_mobile

[![Codemagic build status](https://api.codemagic.io/apps/655719ffe4f8743cfef7f270/655719ffe4f8743cfef7f26f/status_badge.svg)](https://codemagic.io/apps/655719ffe4f8743cfef7f270/655719ffe4f8743cfef7f26f/latest_build)

# Project Structure (latest)

```
lib
|_core -> All code related to logic
    |_[domain]
        |_entity -> Using Freeze and JsonSerializable Annotation to auto generate class type
        |_repository -> Repository interface (remote/local) and implementation (http/fss). Using riverpod annotation
        |_service -> Business Logic using riverpod annotation
|_feature -> All code related to UI
    |_[domain]
        |_controller -> state management and integration with service
        |_screen
        |_widget
|_routing

|_shared
main.dart
```

# Setup:

1. Install the dependencies

```sh
flutter pub get
```

2. Watch and Generate code

```sh
dart run build_runner watch -d
```

# Notes:

- Add Dependencies

```shell
dart pub add name
```

- Add Dev Dependencies

```powershell
dart pub add dev:name
```

# Dev on android simulator

- Change `localhost` to `10.0.2.2` on `.env` file
