import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoice_gen/classes/supplemetary.dart';

part 'invoice_generation_event.dart';
part 'invoice_generation_state.dart';

class InvoiceGenerationBloc
    extends Bloc<InvoiceGenerationEvent, InvoiceGenerationState> {
  InvoiceGenerationBloc() : super(InvoiceGenerationInitial()) {
    on<InvoiceGenerationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
