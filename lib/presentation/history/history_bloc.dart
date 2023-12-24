import 'dart:async';
import 'package:flutter_app_sale_29092023/common/base/base_bloc.dart';
import 'package:flutter_app_sale_29092023/common/base/base_event.dart';
import 'package:flutter_app_sale_29092023/data/model/history.dart';
import 'package:flutter_app_sale_29092023/data/repository/history_repository.dart';
import 'package:flutter_app_sale_29092023/presentation/history/history_event.dart';
import 'package:flutter_app_sale_29092023/util/parser/history_parse.dart';

class HistoryBloc extends BaseBloc{
  HistoryRepository? _historyRepository;
  StreamController<List<History>> _listHistoryController = StreamController();
  Stream<List<History>> getListHistoryStream() => _listHistoryController.stream;

  void setHistoryRepo(HistoryRepository repository) {
    _historyRepository = repository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch(event.runtimeType) {
      case GetHistoryEvent:
        getListHistory();
        break;
      case GetHistoryDetailEvent:
        getHistoryDetail(event as GetHistoryDetailEvent);
        break;
    }
  }
  void getListHistory() {
    loadingSink.add(true);
    _historyRepository?.getListHistoryService()
        .then((historyDTO) {
      List<History> listHistory = historyDTO.map((e) => HistoryParser.parseFromHistoryDTO(e)).toList();
      _listHistoryController.add(listHistory);
    })
        .catchError((error) { messageSink.add(error); })
        .whenComplete(() => loadingSink.add(false));
  }

  void getHistoryDetail(GetHistoryDetailEvent event) {

  }
  @override
  void dispose() {
    super.dispose();
    _listHistoryController.close();
  }
}