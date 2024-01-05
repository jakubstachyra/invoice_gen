part of 'invoice_generation_bloc.dart';

sealed class InvoiceGenerationState extends Equatable {
  const InvoiceGenerationState();

  @override
  List<Object> get props => [];
}

final class InvoiceGenerationInitial extends InvoiceGenerationState {}

final class InvoiceGenerationSeller extends InvoiceGenerationState {
  final Company seller;

  const InvoiceGenerationSeller({required this.seller});
}

final class InvoiceGenerationCustomer extends InvoiceGenerationState {
  final Company buyer;

  const InvoiceGenerationCustomer({required this.buyer});
}

final class InvoiceGenerationProducts extends InvoiceGenerationState {
  final List<Item> items;

  const InvoiceGenerationProducts({required this.items});
}

final class InvoiceGenerationDetails extends InvoiceGenerationState {
  final Details details;

  const InvoiceGenerationDetails({required this.details});
}

final class InvoiceGenerationSuceed extends InvoiceGenerationState {}

final class InvoiceGenerationFailure extends InvoiceGenerationState {}
