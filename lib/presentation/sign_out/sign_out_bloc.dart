import 'package:flutter_app_sale_29092023/common/app_constant.dart';
import 'package:flutter_app_sale_29092023/common/base/base_bloc.dart';
import 'package:flutter_app_sale_29092023/common/base/base_event.dart';
import 'package:flutter_app_sale_29092023/data/local/app_share_preference.dart';
import 'package:flutter_app_sale_29092023/data/repository/authentication_repository.dart';
import 'package:flutter_app_sale_29092023/presentation/sign_out/sign_out_event.dart';

class SignOutBloc extends BaseBloc {
  AuthenticationRepository? _repository;

  void setAuthenticationRepo(AuthenticationRepository repository) {
    _repository = repository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch(event.runtimeType) {
      case SignOutEvent:
        signOut(event as SignOutEvent);
        break;
    }
  }

  void signOut(SignOutEvent event) {
    loadingSink.add(true);
    AppSharePreference.setString(key: AppConstant.TOKEN_KEY, value: "");
    progressSink.add(SignOutSuccessEvent());
    loadingSink.add(false);
  }

  @override
  void dispose() {
    super.dispose();
  }
}