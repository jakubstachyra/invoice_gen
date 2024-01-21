import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoice_gen/classes/invoice.dart';
import 'package:invoice_gen/classes/supplemetary.dart';
import 'package:invoice_gen/pdfAPI/pdf_invoice_api.dart';
part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  List<Item> products = [];
  late Company seller = Company("","","");
  late Company customer = Company("","","");
  late Details details = Details("","",
  DateTime.now().toLocal(),
  DateTime.now().toLocal(),"");
  late Invoice invoice;

  InvoiceBloc() : super(InvoiceInitial()) {
    on<LoadInvoiceEvent>((event, emit) {
      emit(InvoiceInitial());
    });

    on<UpdateSellerEvent>((event, emit) {
      seller = Company(event.name, event.address, event.tin);
      emit(InvoiceSellerUpdated(seller));
    });

    on<NavigateToSellerPageEvent>((event, emit) {
      emit(SellerPageState(seller));
    });

    on<NavigateToCustomerPageEvent>((event, emit) {
      emit(CustomerPageState(customer));
    });

    on<NavigateToProductsPageEvent>((event, emit) {
      emit(InvoiceProductsPageState(products));
    });

    on<NavigateToDetailsPageEvent>((event, emit) {
      emit(InvoiceDetailsPageState(details));
    });
    on<NavigateToSummaryPageEvent>((event, emit) {
      emit(SummaryPageState(seller,customer,products, details));
    });
    
    
    on<UpdateCustomerEvent>((event, emit) {
      customer = Company(event.name, event.address, event.tin);
      emit(InvoiceCustomerUpdated(customer));
      // Po zaktualizowaniu danych klienta, przejdź do ProductsPageState
    });

    on<AddProductEvent>((event, emit) {
      products.add(Item(event.price, event.name, event.tax, event.quantity));
      emit(InvoiceProductsUpdated(List.from(products)));
      // Po dodaniu produktu, możesz chcieć przejść do DetailsPageState
      emit(InvoiceDetailsPageState(details));
    });

    on<UpdateInvoiceDetailsEvent>((event, emit) {
      details = Details(event.place, event.issuance, event.date, event.due, event.invoiceID);
      emit(InvoiceDetailsUpdated(details));
    });

    on<CompleteInvoiceEvent>((event, emit) async {
      invoice = Invoice(seller, customer, products, details);
      // Generowanie PDF może być wywołaniem asynchronicznym, więc emitujesz po zakończeniu
      await PdfInvoiceApi.generate(invoice).then((_) {
        emit(InvoiceCompleted());
      });
    });
  }
}



