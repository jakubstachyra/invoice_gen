part of 'invoice_color_bloc.dart';

abstract class InvoiceColorEvent extends Equatable {
  const InvoiceColorEvent();

  @override
  List<Object> get props => [];
} 

class InvoiceColorChangeEvent extends InvoiceColorEvent {
  final PdfColor newColor;

  const InvoiceColorChangeEvent(this.newColor);

  @override
  List<Object> get props => [newColor];
}
