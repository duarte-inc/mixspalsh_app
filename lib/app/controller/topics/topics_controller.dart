import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:unspalsh_app/app/data/models/topics_model.dart';
import 'package:unspalsh_app/app/data/repository/topics_repository.dart';

class TopicsController extends GetxController
    with StateMixin<List<TopicModel>> {
  final TopicsRepository repository;
  TopicsController({@required this.repository}) : assert(repository != null);
  int pageNumber;
  @override
  void onInit() {
    getTopics();
    super.onInit();
  }

// TOPIC MODEL
  final _topicModel = List<TopicModel>().obs;
  List<TopicModel> get topicModel => this._topicModel.toList();
  set topicModel(topics) => this._topicModel.assignAll(topics);

  // ignore: missing_return
  Future<List<TopicModel>> getTopics() async {
    var data;
    try {
      data = await repository.getTopics();
      change(data, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
