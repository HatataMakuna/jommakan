import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jom_makan/pages/Admin/views/base_views.dart';
import 'package:jom_makan/pages/Admin/views/inventory/add_food.dart';
import 'package:jom_makan/pages/Admin/widgets/table/controller.dart';
import 'package:jom_makan/pages/Admin/widgets/table/table_item.dart';
import 'package:jom_makan/server/food/food.dart';

import 'package:jom_makan/pages/Admin/style/colors.dart';
import 'package:jom_makan/pages/Admin/widgets/table/table.dart';
import 'package:jom_makan/server/payment/add_payment.dart';

class MonthlySales extends AdminView {
  MonthlySales({super.key});

  @override
  State<StatefulWidget> createState() => _PaymentSearch();
}

class _PaymentSearch extends AdminStateView<MonthlySales> {
  late AdminTableController paymentController;
  late AdminTableController courseController;

  // Get the current date in the format 'yyyy-MM-dd'
String currentDate = DateFormat('MMM').format(DateTime.now());

  var itemData = [];
  final AddPayment paymentDisplay = AddPayment();
  List<Map<String, dynamic>> _paymentItems = [];

  @override
  void initState() {
    super.initState();
    paymentController = AdminTableController(items: []);
    _getData();
  }

  String searchKeyword = '';

  void _search(String keyword) {
    setState(() {
      searchKeyword = keyword;
    });

    // Trigger data refresh based on the new search keyword
    _getData();
  }

  void _getData() async {
    try {
      final data = await paymentDisplay.getPaymentData();

      setState(() {
        _paymentItems = data;


// Filter data based on the search term
        if (searchKeyword.isNotEmpty) {
          _paymentItems = _paymentItems.where((item) {
            return item['payment_date'].toLowerCase().contains(searchKeyword.toLowerCase());
          }).toList();

           // Clear the existing data
      itemData.clear();
        
        for (int i = 0; i < _paymentItems.length; i++) {
          String foodNameCorrect = 'foodName: ${_paymentItems[i]['payment_date']}';
          print('Food Name: ' + foodNameCorrect);

          itemData.add({
            'paymentID': _paymentItems[i]['paymentID'],
            'payment_method': _paymentItems[i]['payment_method'],
            'payment_date': _paymentItems[i]['payment_date'],
            'payment_time': _paymentItems[i]['payment_time'],
            'total_price': _paymentItems[i]['total_price'],
          });
        }
        }

        paymentController = AdminTableController(items: [
          AdminTableItem(
              itemView: paymentItemView,
              width: 150,
              label: "Payment ID",
              prop: 'paymentID',
            fixed: FixedDirection.left
              ),
          AdminTableItem(
            itemView: paymentItemView,
            width: 150,
            label: "Payment Method",
            prop: 'payment_method',
          ),
          AdminTableItem(
            itemView: paymentItemView,
            width: 150,
            label: "Payment Date",
            prop: 'payment_date',
          ),
          AdminTableItem(
            itemView: paymentItemView,
            width: 150,
            label: "Payment Time",
            prop: 'payment_time',
          ),
          AdminTableItem(
            itemView: paymentItemView,
            width: 150,
            label: "Total Price",
            prop: 'total_price',
          ),
          
          AdminTableItem(
              itemView: paymentItemView,
              width: 150,
              label: "More",
              fixed: FixedDirection.right,
              prop: 'action'),
        ]);
        paymentController.setNewData(itemData);
      });
    } catch (e) {
      print('Error loading Food data: $e');
    }
  }

  Widget paymentItemView(
    BuildContext context, int index, dynamic data, AdminTableItem item) {
  if (index == -1) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        item.label,
        style: TextStyle(color: AdminColors().get().secondaryColor),
      ),
    );
  } else {
    if (item.prop == 'action') {
      return Container(
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Call the function to delete the item at index
                _deleteItem(index);
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                // Call the function to update the payment method
                _showSearchDialog();
              },
              child: const Text(
                "Update",
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      alignment: Alignment.center,
      child: Text(
        "${paymentController.ofData(index)[item.prop!]}",
        style: TextStyle(color: AdminColors().get().secondaryColor),
      ),
    );
  }
}


void _showSearchDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Month'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              for (int month = 1; month <= 12; month++)
                ListTile(
                  title: Text(DateFormat('MMMM').format(DateTime(2023, month))),
                  onTap: () {
                    _search(DateFormat('MMM').format(DateTime(2023, month)));
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        ),
      );
    },
  );
}





  // Function to delete the item at the specified index
  void _deleteItem(int index) {
    setState(() {
       if (index >= 0 && index < _paymentItems.length) {
      // Remove the item from the _promoItems list
      var deletedItem = _paymentItems.removeAt(index);
      print('deleteItem:  + $deletedItem');

      // for (int i = 0; i < _promoItems.length; i++) {
       
      // Remove the item from the itemData list
      itemData.removeWhere((item) =>
          item['paymentID'] == deletedItem['paymentID'] &&
          item['payment_method'] == deletedItem['payment_method'] &&
          item['payment_date'] == deletedItem['payment_date'] &&
          item['payment_time'] == deletedItem['payment_time']);
       
       // Delete the item from the database
      paymentDisplay.deletePayment(deletedItem['paymentID']);


      // Update the table controller with the new data
    paymentController.setNewData(itemData);
      }
    });
  }

  @override
  Widget? buildForLarge(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Container(
        width: size.maxWidth,
        margin: const EdgeInsets.all(20),
        height: size.maxHeight,
         child: Column(
          children: [
            IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
             _showSearchDialog();
             
            },
          ),
      
            const SizedBox(height: 10), // Add some space between button and table
            Expanded(
              child: AdminTable(
                controller: paymentController,
                fixedHeader: true,
              ),
            ),
          ],
        ),
      );
    });
  }

  void _updatePaymentMethod(int index, String newPaymentMethod) {
  // Update the UI
  setState(() {
    _paymentItems[index]['payment_method'] = newPaymentMethod;

    // Update the table controller with the new data
    paymentController.setNewData(itemData);
  });

  // Update the backend
  String paymentID = _paymentItems[index]['paymentID'];
  paymentDisplay.updatePaymentMethod(paymentID, newPaymentMethod);
}

}