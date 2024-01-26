part of 'invoice_menagment_bloc.dart';

sealed class InvoiceMenagmentEvent extends Equatable {
  const InvoiceMenagmentEvent();

  @override
  List<Object> get props => [];

}

class DeleteInvoiceEvent extends InvoiceMenagmentEvent {
    final String resourceId;

  const DeleteInvoiceEvent(this.resourceId);
}

