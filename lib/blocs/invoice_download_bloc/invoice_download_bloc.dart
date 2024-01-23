import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'invoice_download_event.dart';
part 'invoice_download_state.dart';

class InvoiceDownloadBloc extends Bloc<InvoiceDownloadEvent, InvoiceDownloadState> {
  InvoiceDownloadBloc() : super(InvoiceDownloadInitial()) {
    on<InvoiceDownloadEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
