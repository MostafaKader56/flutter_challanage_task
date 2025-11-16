import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) {
      printLogs(change, title: bloc.runtimeType.toString());
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    printLogs(transition, title: bloc.runtimeType.toString());
  }
}
