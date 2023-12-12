
import 'package:get_it/get_it.dart';
import 'package:test/core/constants/constants.dart';
import 'package:test/core/network_client/network_client.dart';
import 'package:test/data/data_source/remote_source/provider.dart';
import 'package:test/data/domain/repository/main.dart';
import 'package:test/data/domain/usecase/user_uscase.dart';
import 'package:test/data/repository/main.dart';
import 'package:test/presentation/cubit/users/users_cubit.dart';

final inject = GetIt.instance;

Future<void> initDi() async {
  // ! cubits need register
  inject.registerFactory(() => UsersCubit(inject()));
 

  // ! use case need to register
  inject.registerLazySingleton(() => UsersUseCase(inject()));
  
 
  inject.registerLazySingleton<IMainRepository>(
      () => MainRepository(inject()));

  // ! local source init
  // var pref = await SharedPreferences.getInstance();
  // inject.registerLazySingleton(() => pref);

  /// athlete
  inject.registerFactory(() => NetworkClient());
  var dio = await inject<NetworkClient>().init();
  inject.registerFactory(() => ApiClient(dio, BASE_URL));
}
