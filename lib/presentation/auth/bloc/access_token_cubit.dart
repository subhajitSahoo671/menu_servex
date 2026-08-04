// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:menu_servex/domain/usecases/auth/access_token.dart';
// import 'package:menu_servex/presentation/auth/bloc/access_token_state.dart';
// import 'package:menu_servex/service_locator.dart';

// class AccessTokenCubit extends Cubit<AccessTokenState> {
//   AccessTokenCubit() : super(AccessTokenLoading());

//   Future<void> getAccessToken () async{
//      try {
//       var data = await sl<AccessTokenUsecase>().call().timeout(const Duration(seconds: 20));
//       if (data != null) {
//         emit(AccessTokenLoaded(accessToken: data));
        
//       } else {
//          print("getAccessToken failed: token not found");
//         emit(AccessTokenFailure());
        
//       }
//     } catch (e) {
//       print("getAccessToken timeout or error: $e");
//       emit(AccessTokenFailure());
//     }
//   }
// }