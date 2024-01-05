part of 'invoice_menagment_bloc.dart';

sealed class InvoiceGenerationBlocEvent extends Equatable {
  const InvoiceGenerationBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadInvoices extends InvoiceGenerationBlocEvent {}

class AddInvoice extends InvoiceGenerationBlocEvent {
  final Invoice invoice;

  const AddInvoice(this.invoice);

  @override
  List<Object> get props => [invoice];
}

class RemoveInvoice extends InvoiceGenerationBlocEvent {
  final Invoice invoice;

  const RemoveInvoice(this.invoice);

  @override
  List<Object> get props => [invoice];
}
