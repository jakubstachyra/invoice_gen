import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoice_gen/classes/invoice.dart';

part 'invoice_menagment_event.dart';
part 'invoice_menagmentstate.dart';

class InvoiceMenagmentBloc
    extends Bloc<InvoiceGenerationBlocEvent, InvoiceMenagmentState> {
  InvoiceMenagmentBloc() : super(InvoiceMenagmentInitial()) {
    on<LoadInvoices>(
      (event, emit) async {
        await Future<void>.delayed(const Duration(seconds: 1));
        emit(const InvoiceMenagmentLoaded(invoices: <Invoice>[]));
      },
    );
    on<AddInvoice>(
      (event, emit) {
        if (state is InvoiceMenagmentLoaded) {
          final state = this.state as InvoiceMenagmentLoaded;

          emit(InvoiceMenagmentLoaded(
              invoices: List.from(state.invoices)..add(event.invoice)));
        }
      },
    );
    on<RemoveInvoice>(
      (event, emit) {
        if (state is InvoiceMenagmentLoaded) {
          final state = this.state as InvoiceMenagmentLoaded;
          emit(InvoiceMenagmentLoaded(
              invoices: List.from(state.invoices)..remove(event.invoice)));
        }
      },
    );
  }
}
