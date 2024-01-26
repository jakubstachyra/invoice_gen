import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/classes/supplemetary.dart';
import 'package:invoice_gen/pdfAPI/pdf_api.dart';
part 'invoice_event.dart';
part 'invoice_state.dart';



class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  List<Item> items = [];
  User? currentUser = FirebaseAuth.instance.currentUser;
  late List<Company> userCustomers = [];
  late Company seller = Company("","","");
  late Company customer = Company("","","");
  late bool isEditing = false;
  late String editingInvoiceID = "";
  late Details details = Details("","",
  DateTime.now().toLocal(),
  DateTime.now().toLocal(),"");
  
  InvoiceBloc() : super(InvoiceInitial()) {
    on<InitInvoiceEvent>((event, emit) {
      emit(InvoiceInitial());
    });
    on<InvoiceCancelledEvent>((event, emit) {
      resetInvoiceData();
      emit(InvoiceCancelled());
      emit(InvoiceInitial());
    });
    on<NavigateToSellerPageEvent>((event, emit) {
      emit(SellerPageState(seller));
    });

    on<NavigateToCustomerPageEvent>((event, emit) {
      emit(CustomerPageState(customer));
    });

    on<NavigateToCustomersPageEvent>((event, emit) {
      emit(CustomersPageState(userCustomers));
    });

    on<NavigateToProductsPageEvent>((event, emit) {
      emit(InvoiceProductsPageState(items));
    });

    on<NavigateToDetailsPageEvent>((event, emit) {
      emit(InvoiceDetailsPageState(details));
    });
    on<NavigateToSummaryPageEvent>((event, emit) {
      emit(SummaryPageState(seller,customer,items, details));
    });

    on<NavigateToPdfPageEvent>((event, emit) {
      final String filePath = event.filePath;
      emit(PdfPage(filePath));
    });
    
    on<EditInvoiceEvent>((event, emit){
      isEditing = true;
      seller = event.seller;
      customer = event.customer;
      details = event.details;
      items = event.items;
      editingInvoiceID = event.invoiceID;
      emit(EditInvoiceState());
      emit(SellerPageState(seller));
    });
    
    on<UpdateSellerEvent>((event, emit) {
      seller = Company(event.name, event.address, event.tin);
      emit(InvoiceSellerUpdated(seller));
    });
    
    on<UpdateCustomerEvent>((event, emit) {
      customer = Company(event.name, event.address, event.tin);
      emit(InvoiceCustomerUpdated(customer));
    });

    on<AddCustomerToFireBaseEvent>((event, emit){
      uploadCustomer(Company(event.name, event.adress, event.tin));
      emit(AddedCustomerToFireBase());
      });

    on<DownloadCustomersEvent>(((event, emit) async {
      userCustomers= await downloadCustomers();
      emit(DownloadedCustomersState());
      emit(CustomersPageState(userCustomers));
    }));

    on<AddProductEvent>((event, emit) {
      items.add(Item(event.price, event.name, event.tax, event.quantity));
      emit(InvoiceProductsUpdated(List.from(items)));

      emit(InvoiceDetailsPageState(details));
    });

    on<UpdateInvoiceDetailsEvent>((event, emit) {
      details = Details(event.place, event.issuance, event.date, event.due, event.invoiceID);
      emit(InvoiceDetailsUpdated(details));
    });

    on<CompleteInvoiceEvent>((event, emit) async {
          if (currentUser != null) {
            if(isEditing == true)
            {
              await PdfApi.updateData(editingInvoiceID, seller, customer, items, details);
              emit(InvoiceCompleted());
            }
            else{
               await PdfApi.uploadInvoice(seller, customer, items, details);
              emit(InvoiceCompleted());
            }

            resetInvoiceData();
            emit(InvoiceInitial());
          }
        });
      }

    void resetInvoiceData() {
    items.clear();
    seller = Company("", "", "");
    customer = Company("", "", "");
    details = Details("", "", DateTime.now().toLocal(),
                      DateTime.now().toLocal(), "");
    isEditing = false;
    editingInvoiceID = "";
  }
  Future<void> uploadCustomer(Company customer) async{
  var customerJson = customer.toMap();

  User? currentUser = FirebaseAuth.instance.currentUser;
  final invoice = FirebaseFirestore.instance.collection('userFiles').doc(currentUser!.uid).collection('clients').doc();

  await invoice.set(customerJson);
}
 Future<List<Company>> downloadCustomers() async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    throw Exception("User not logged in");
  }

  CollectionReference collection = FirebaseFirestore.instance.collection('userFiles').doc(currentUser.uid).collection('clients');

  QuerySnapshot querySnapshot = await collection.get();

  return querySnapshot.docs.map((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    Company customer = Company.fromMap(data);
    return customer;
  }).toList();
}

}



