import 'package:flutter_app_sale_29092023/common/base/base_event.dart';
import 'package:flutter_app_sale_29092023/data/api/dto/history_dto.dart';
import 'package:flutter_app_sale_29092023/data/api/dto/product_dto.dart';

class GetHistoryEvent extends BaseEvent {
  @override
  List<Object?> get props => [];
}

class GetHistoryDetailEvent extends BaseEvent {
  HistoryDTO? historyDetail;
  GetHistoryDetailEvent(this.historyDetail);
  @override
  List<Object?> get props => [];
}

