import 'supplemetary.dart';

class Invoice {
  final Company _seller;
  final Company _customer;
  final List<String> _items;
  final Details _details;

  Invoice(this._seller, this._customer, this._items, this._details);

  Company get seller {
    return _seller;
  }

  Company get customer {
    return _customer;
  }

  List<String> get items {
    return _items;
  }

  Details get details {
    return _details;
  }
}
