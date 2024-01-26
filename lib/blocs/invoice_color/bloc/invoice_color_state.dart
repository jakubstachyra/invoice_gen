part of 'invoice_color_bloc.dart';

abstract class InvoiceColorState extends Equatable {
  const InvoiceColorState();
  
  @override
  List<Object> get props => [];
}

class InvoiceColorInitial extends InvoiceColorState {}

class InvoiceColorChanged extends InvoiceColorState {
  final PdfColor color;

  const InvoiceColorChanged(this.color);

  @override
  List<Object> get props => [color];
}
