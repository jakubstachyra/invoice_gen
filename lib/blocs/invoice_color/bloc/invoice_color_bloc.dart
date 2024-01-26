import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoice_gen/blocs/invoice_color/functions_color.dart';
import 'package:pdf/pdf.dart';

part 'invoice_color_event.dart';
part 'invoice_color_state.dart';


class InvoiceColorBloc extends Bloc<InvoiceColorEvent, InvoiceColorState> {
  InvoiceColorBloc() : super(InvoiceColorInitial()) {
    on<InvoiceColorChangeEvent>(_onInvoiceColorChanged);
  }

  Future<void> _onInvoiceColorChanged(
    InvoiceColorChangeEvent event, 
    Emitter<InvoiceColorState> emit,
  ) async {
    // Zapisywanie nowego koloru w preferencjach użytkownika
    await InvoiceColorPreferences.setDefaultInvoiceColor(event.newColor);

    // Emitowanie stanu z nowym kolorem
    emit(InvoiceColorChanged(event.newColor));
  }
}


