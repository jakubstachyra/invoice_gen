import 'supplemetary.dart';

class Invoice {
  final Company _seller;
  final Company _customer;
  final List<Item> _items;
  final Details _details;
  String id;
  Invoice(this._seller, this._customer, this._items, this._details,this.id);

   Company get seller {
    return _seller;
   }
   Company get customer {
    return _customer;
   }

   List<Item> get items {
     return _items;
   }

   Details get details {
     return _details;
   }
  //  Status get status{
  //   return _status;
  //  }
  //  set setStatus(Status status) {
  //   _status = status;
  // }
}
enum Status {paid, open}