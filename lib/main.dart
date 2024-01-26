import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/app.dart';
import 'package:invoice_gen/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/classes/utils.dart';
import 'package:user_repository/user_repository.dart';
import 'firebase_options.dart';

import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  var fontLoader = FontLoader("Mukta");
  fontLoader.addFont(Utils.loadMuktaRegularFont());
  await fontLoader.load();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(userRepository: FirebaseUserRepo()),
      ),
      BlocProvider<InvoiceBloc>(
        create: (context) => InvoiceBloc(),
      ),
      
    ],
    child: MyApp(FirebaseUserRepo()),
  ));
}

