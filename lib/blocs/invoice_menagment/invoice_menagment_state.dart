part of 'invoice_menagment_bloc.dart';

sealed class InvoiceMenagmentState extends Equatable {
  const InvoiceMenagmentState();
  
  @override
  List<Object> get props => [];
}

final class InvoiceMenagmentInitial extends InvoiceMenagmentState {}

final class DeleteinvoiceState extends InvoiceMenagmentState {}
