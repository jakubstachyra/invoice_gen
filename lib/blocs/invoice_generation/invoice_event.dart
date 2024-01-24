part of 'invoice_bloc.dart';

abstract class InvoiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadInvoiceEvent extends InvoiceEvent {}

class InitInvoiceEvent extends InvoiceEvent {}

class CompleteInvoiceEvent extends InvoiceEvent {}

class NavigateToSellerPageEvent extends InvoiceEvent {}

class NavigateToCustomerPageEvent extends InvoiceEvent {}

class NavigateToProductsPageEvent extends InvoiceEvent {}

class NavigateToDetailsPageEvent extends InvoiceEvent {}

class NavigateToSummaryPageEvent extends InvoiceEvent {}

class NavigateToPdfPageEvent extends InvoiceEvent {
  final String filePath;
  NavigateToPdfPageEvent(this.filePath);
}

class UpdateSellerEvent extends InvoiceEvent {
  final String name;
  final String address;
  final String tin;
  UpdateSellerEvent({required this.name, required this.address, required this.tin});
}

class UpdateCustomerEvent extends InvoiceEvent {
  final String name;
  final String address;
  final String tin;
  UpdateCustomerEvent({required this.name, required this.address, required this.tin});
}

class AddProductEvent extends InvoiceEvent {
  final String name;
  final double price;
  final int tax;
  final int quantity;

  AddProductEvent({required this.name, required this.price, required this.tax, required this.quantity});
}

class UpdateInvoiceDetailsEvent extends InvoiceEvent {
  final String invoiceID;
  final String place;
  final String issuance;
  final DateTime date;
  final DateTime due;
  UpdateInvoiceDetailsEvent({required this.invoiceID, required this.date, required this.place, required this.issuance, required this.due});
}




