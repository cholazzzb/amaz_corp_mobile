import 'package:amaz_corp_mobile/core/location/domain/entity/room_entity.dart';
import 'package:amaz_corp_mobile/core/location/domain/service/location_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'building_drawer_controller.g.dart';

enum AsyncState {
  loading,
  success,
  error,
}

@riverpod
class BuildingDrawerController extends _$BuildingDrawerController {
  @override
  Map<String, (AsyncState, List<Room>)> build() => {};

  Future<void> updateListRoomByBuildingID(buildingID) async {
    try {
      state.putIfAbsent(buildingID, () {
        List<Room> empty = [];
        return (AsyncState.loading, empty);
      });
      if (state.containsKey(buildingID)) {
        state.update(buildingID, (value) => (AsyncState.loading, []));
      } else {
        state[buildingID] = (AsyncState.loading, []);
      }
      final rooms =
          await ref.watch(GetListRoomsByBuildingIDProvider(buildingID).future);
      state.update(buildingID, (value) => (AsyncState.success, rooms));
    } catch (err) {
      state.update(buildingID, (value) => (AsyncState.error, []));
    }
  }
}
