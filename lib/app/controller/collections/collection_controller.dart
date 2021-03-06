import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:unspalsh_app/app/data/models/collection_model.dart';
import '../../data/repository/collection_repository.dart';

class CollectionController extends GetxController
    with StateMixin<List<CollectionModel>> {
  final CollectionRepositroy repository;
  CollectionController({@required this.repository})
      : assert(repository != null);

  @override
  void onInit() {
    getCollection();
    super.onInit();
  }

// index
  final _index = 0.obs;
  int get index => this._index.value;
  set index(value) => this._index.value = value;
// CollectionID
  final _collectionId = "".obs;
  get collectionId => this._collectionId.value;
  set collectionId(value) => this._collectionId.value = value;

// CollectionModel
  final _collectionModel = List<CollectionModel>().obs;
  List<CollectionModel> get collectionModel => this._collectionModel.toList();
  void set(collections) => this._collectionModel.assignAll(collections);

  Future<List<CollectionModel>> getCollection() async {
    var data;
    try {
      data = await repository.getCollection();
      change(data, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  collectionDetails({String collectionId, int index}) {
    this.collectionId = collectionId;
    this.index = index;
    Get.toNamed("/collectiondetail");
  }
}
