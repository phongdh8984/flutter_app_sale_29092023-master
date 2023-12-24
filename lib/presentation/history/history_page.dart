import 'package:flutter/material.dart';
import 'package:flutter_app_sale_29092023/common/widget/loading_widget.dart';
import 'package:flutter_app_sale_29092023/data/api/api_service.dart';
import 'package:flutter_app_sale_29092023/data/api/dto/history_dto.dart';
import 'package:flutter_app_sale_29092023/data/model/history.dart';
import 'package:flutter_app_sale_29092023/data/repository/history_repository.dart';
import 'package:flutter_app_sale_29092023/presentation/history/history_bloc.dart';
import 'package:flutter_app_sale_29092023/presentation/history/history_event.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/base/base_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var historyRepository = HistoryRepository();
    // historyRepository.setApiService(ApiService());
    // historyRepository.getListHistoryService()
    // .then((value) => print(value))
    // .catchError((value) => print(value));

  }
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      providers: [
        Provider(create: (context) => ApiService()),
        ProxyProvider<ApiService, HistoryRepository>(
          create: (context) => HistoryRepository(),
          update: (_, request, repository) {
            repository ??= HistoryRepository();
            repository.setApiService(request);
            return repository;
          },
        ),
        ProxyProvider<HistoryRepository, HistoryBloc>(
          create: (context) => HistoryBloc(),
          update: (_, historyRepo, bloc) {
            bloc?.setHistoryRepo(historyRepo);
            return bloc ?? HistoryBloc();
          },
        )
      ],
      child: HistoryContainer(),
      appBar: AppBar(
        title: const Text("Lịch sử đơn hàng"),
      ),
    );
  }
}
class HistoryContainer extends StatefulWidget {
  const HistoryContainer({super.key});

  @override
  State<HistoryContainer> createState() => _HistoryContainerState();
}

class _HistoryContainerState extends State<HistoryContainer> {
  HistoryBloc? _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = context.read();
    _bloc?.getListHistory();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: StreamBuilder<List<History>>(
              initialData: const [],
              stream: _bloc?.getListHistoryStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError || snapshot.data?.isEmpty == true) {
                  return Container(
                    child: Center(child: Text("Data empty")),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      var itemHistory = snapshot.data?[index];
                      return _buildItemHistory(itemHistory, () {
                        _bloc?.eventSink.add(GetHistoryDetailEvent(itemHistory as HistoryDTO?));
                      });
                    }
                );
              }
          ),
        ),
        LoadingWidget(bloc: _bloc),
      ],
    );
  }

  Widget _buildItemHistory(History? history, Function()? eventHistoryDetail) {
    if (history == null) return Container();
    return SizedBox(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Text(
                  "Ngày : ${DateFormat('yyyy-MM-dd hh:mm')
                      .format(history.dateCreate)}",
                  style: const TextStyle(fontSize: 16)),
              Text(
                  "Tổng tiền : ${NumberFormat("#,###", "en_US")
                      .format(history.price)} đ",
                  style: const TextStyle(fontSize: 12)),
              ElevatedButton(
                onPressed: eventHistoryDetail,
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color.fromARGB(200, 240, 102, 61);
                      } else {
                        return const Color.fromARGB(230, 240, 102, 61);
                      }
                    }),
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10))))),
                child:
                const Text("Xem chi tiết", style: TextStyle(fontSize: 14)),
              )
            ]
          ),
        ),
      ),
    );
  }
}

