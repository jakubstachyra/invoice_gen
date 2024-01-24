import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/settings_screen_bloc/settings_screen_event.dart';
import 'package:invoice_gen/blocs/settings_screen_bloc/settings_screen_state.dart';

class SettingsScreenBloc
    extends Bloc<SettingsScreenEvent, SettingsScreenState> {
  SettingsScreenBloc() : super(SettingsScreenInitial()) {
    on<LoadSettingsScreen>((event, emit) {
      // Implement your logic for loading settings
      emit(SettingsScreenLoaded());
    });
  }
}
