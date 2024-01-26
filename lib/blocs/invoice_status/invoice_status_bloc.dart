// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:invoice_gen/classes/invoice.dart';
// import 'package:invoice_gen/pdfAPI/pdf_api.dart';

// part 'invoice_status_event.dart';
// part 'invoice_status_state.dart';

// class InvoiceStatusBloc extends Bloc<InvoiceStatusEvent, InvoiceStatusState> {
//   InvoiceStatusBloc() : super(InvoiceStatusInitial()) {
//     on<InvoiceStatusEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//     on<ChangeStatusInvoiceEvent>((event, emit){
//       if(event.invoice.status == Status.open)
//       {
//         event.invoice.setStatus = Status.paid;
//         PdfApi.updateInvoiceStatus(event.invoice.id, event.invoice.status);
//         emit(InvoiceStatusChanged());
//       }
//       else if(event.invoice.status == Status.paid){
//         event.invoice.setStatus = Status.open;
//         PdfApi.updateInvoiceStatus(event.invoice.id, event.invoice.status);
//         emit(InvoiceStatusChanged());
//       }
//     });
    
//   }
// }
