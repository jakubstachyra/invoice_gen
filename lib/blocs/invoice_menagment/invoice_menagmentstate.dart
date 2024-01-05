part of 'invoice_menagment_bloc.dart';

sealed class InvoiceMenagmentState extends Equatable {
  const InvoiceMenagmentState();

  @override
  List<Object> get props => [];
}

final class InvoiceMenagmentInitial extends InvoiceMenagmentState {}

final class InvoiceMenagmentFailure extends InvoiceMenagmentState {}

final class InvoiceMenagmentLoaded extends InvoiceMenagmentState {
  final List<Invoice> invoices;

  const InvoiceMenagmentLoaded({required this.invoices});

  @override
  List<Object> get props => [invoices];
}
