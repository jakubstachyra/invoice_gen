import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/classes/invoice.dart';
import 'package:invoice_gen/classes/supplemetary.dart';
import 'package:invoice_gen/pdfAPI/pdf_api.dart';
part 'invoice_event.dart';
part 'invoice_state.dart';



class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {

  List<Item> products = [];
  User? currentUser = FirebaseAuth.instance.currentUser;
  late Company seller = Company("","","");
  late Company customer = Company("","","");
  late Details details = Details("","",
  DateTime.now().toLocal(),
  DateTime.now().toLocal(),"");
  late Invoice invoice;
  late String filePath = "";
  
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
    on<NavigateToPdfPageEvent>((event, emit) {
      final String filePath = event.filePath;
      emit(PdfPage(filePath));
    });
    
    
    on<UpdateCustomerEvent>((event, emit) {
      customer = Company(event.name, event.address, event.tin);
      emit(InvoiceCustomerUpdated(customer));
    });


    on<AddProductEvent>((event, emit) {
      products.add(Item(event.price, event.name, event.tax, event.quantity));
      emit(InvoiceProductsUpdated(List.from(products)));

      emit(InvoiceDetailsPageState(details));
    });

    on<UpdateInvoiceDetailsEvent>((event, emit) {
      details = Details(event.place, event.issuance, event.date, event.due, event.invoiceID);
      emit(InvoiceDetailsUpdated(details));
    });
    on<CompleteInvoiceEvent>((event, emit) async {
          if (currentUser != null) {
            PdfApi.uploadData(seller, customer, products, details);
            emit(InvoiceCompleted());
            // Reset state and data after invoice completion
            _resetInvoiceData();
            emit(InvoiceInitial());
          }
        });
        
      }
    void _resetInvoiceData() {
    products.clear();
    seller = Company("", "", "");
    customer = Company("", "", "");
    details = Details("", "", DateTime.now().toLocal(),
                      DateTime.now().toLocal(), "");
  }
}



