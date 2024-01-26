import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'invoice_menagment_event.dart';
part 'invoice_menagment_state.dart';

class InvoiceMenagmentBloc extends Bloc<InvoiceMenagmentEvent, InvoiceMenagmentState> {
  InvoiceMenagmentBloc() : super(InvoiceMenagmentInitial()) {
    on<InvoiceMenagmentEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<DeleteInvoiceEvent>((event, emit){
      
    });
  }
}
