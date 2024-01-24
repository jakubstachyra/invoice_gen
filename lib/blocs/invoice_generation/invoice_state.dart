part of 'invoice_bloc.dart';

abstract class InvoiceState extends Equatable {
  @override
  List<Object> get props => [];
}

class InvoiceInitial extends InvoiceState {}

class InvoiceCompleted extends InvoiceState {}

class InvoiceCancelled extends InvoiceState {}

class InvoiceSellerUpdated extends InvoiceState {
  final Company seller;
  InvoiceSellerUpdated(this.seller);
}

class InvoiceCustomerUpdated extends InvoiceState {
  final Company customer;
  InvoiceCustomerUpdated(this.customer);
}

class InvoiceProductsUpdated extends InvoiceState {
  final List<Item> products;
  InvoiceProductsUpdated(this.products);
}

class InvoiceDetailsUpdated extends InvoiceState {
  final Details details;
  InvoiceDetailsUpdated(this.details);
}

class PdfPage extends InvoiceState {
  final String filePath;
  PdfPage(this.filePath);
}

class InvoiceFailure extends InvoiceState {
  final String message;
  InvoiceFailure({this.message = 'Error InvoiceGeneration'});
}

class EditInvoiceState extends InvoiceState{}

class SellerPageState extends InvoiceState {
  final Company seller;
  SellerPageState(this.seller);
}

class CustomerPageState extends InvoiceState {
      final Company customer;
    CustomerPageState(this.customer);
}
class InvoiceProductsPageState extends InvoiceState {
  final List<Item> products;
  InvoiceProductsPageState(this.products);
}
class InvoiceDetailsPageState extends InvoiceState {
  final Details details;
  InvoiceDetailsPageState(this.details);
}
class SummaryPageState extends InvoiceState{
    final Company seller;
    final Company customer;
    final List<Item> products;
    final Details details;
    SummaryPageState(this.seller, this.customer,this.products, this.details);
}
