# amaz_corp_mobile
 
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

# apiUrl: 
https://amaz-corp-be-staging.onrender.com/

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