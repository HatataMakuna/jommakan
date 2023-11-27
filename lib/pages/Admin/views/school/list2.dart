import 'package:flutter/material.dart';
import 'package:jom_makan/pages/Admin/views/base_views.dart';
import 'package:jom_makan/pages/Admin/views/school/add_food.dart';
import 'package:jom_makan/pages/Admin/widgets/table/controller.dart';
import 'package:jom_makan/pages/Admin/widgets/table/table_item.dart';
import 'package:jom_makan/server/food/food.dart';

import 'package:jom_makan/pages/Admin/style/colors.dart';
import 'package:jom_makan/pages/Admin/widgets/table/table.dart';

class StockView extends AdminView {
  StockView({super.key});

  @override
  State<StatefulWidget> createState() => _StockView();
}

class _StockView extends AdminStateView<StockView> {
  late AdminTableController schoolController;
  late AdminTableController courseController;

  var itemData = [];
  final Food foodDisplay = Food();
  List<Map<String, dynamic>> _foodItems = [];

  @override
  void initState() {
    super.initState();
    courseController = AdminTableController(items: []);
    _getData();
  }

  void _getData() async {
    try {
      final data = await foodDisplay.getFoodData();

      setState(() {
        _foodItems = data;

         // Sort the _foodItems list by the 'qty_in_stock' column in ascending order
_foodItems.sort((a, b) => int.parse(a['qty_in_stock'].toString()).compareTo(int.parse(b['qty_in_stock'].toString())));



          itemData = _foodItems.map((item) {
        return {
          'foodID': item['foodID'],
          'foodName': item['food_name'],
          'stallID': item['stallID'],
          'mainCategory': item['main_category'],
          'subCategory': item['sub_category'],
          'foodPrice': item['food_price'],
          'qtyInStock': item['qty_in_stock'],
          'foodImage': item['food_image'],
          };
      }).toList();

        courseController = AdminTableController(items: [
          AdminTableItem(
              itemView: itemView,
              width: 130,
              label: "Food ID",
              prop: 'foodID',
              ),
          AdminTableItem(
            itemView: itemView,
            width: 150,
            label: "Food Name",
            prop: 'foodName',
            fixed: FixedDirection.left
          ),
          AdminTableItem(
            itemView: itemView,
            width: 150,
            label: "Stall ID",
            prop: 'stallID',
          ),
          AdminTableItem(
            itemView: itemView,
            width: 150,
            label: "Main Category",
            prop: 'mainCategory',
          ),
          AdminTableItem(
            itemView: itemView,
            width: 150,
            label: "Sub Category",
            prop: 'subCategory',
          ),
          AdminTableItem(
              itemView: itemView,
              width: 100,
              label: "Food Price",
              prop: 'foodPrice'),
          AdminTableItem(
              itemView: itemView,
              width: 150,
              label: "Quantity",
              fixed: FixedDirection.right,
              prop: 'qtyInStock'),
          AdminTableItem(
              itemView: itemView,
              width: 200,
              label: "Food Image",
              prop: 'foodImage'),
          AdminTableItem(
              itemView: itemView,
              width: 150,
              label: "More",
              prop: 'action'),
        ]);
        courseController.setNewData(itemData);
      });
    } catch (e) {
      print('Error loading Food data: $e');
    }
  }

  Widget itemView(
      BuildContext context, int index, dynamic data, AdminTableItem item) {
    if (index == -1) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          item.label,
          style: TextStyle(color: AdminColors()
              .get()
              .secondaryColor),
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
          // Call the function to delete the item at index
          _showQuantityDialog(index);
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
          "${courseController.ofData(index)[item.prop!]}",
          style: TextStyle(color: AdminColors()
              .get()
              .secondaryColor),
        ),
      );
    }
  }


  void _showQuantityDialog(int index) {
  int newQuantity = 0;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Update Quantity'),
        content: TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            newQuantity = int.tryParse(value) ?? 0;
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _updateQuantity(index, newQuantity);
              Navigator.of(context).pop();
            },
            child: const Text('Update'),
          ),
        ],
      );
    },
  );
}



  void _updateQuantity(int index, int newQuantity) {
  setState(() {
    if (index >= 0 && index < _foodItems.length) {
      var updatedItem = _foodItems[index];
      updatedItem['qty_in_stock'] = newQuantity;

      // Update the item in the itemData list as well
      var updatedItemIndex = itemData.indexWhere((item) => item['foodID'] == updatedItem['foodID']);
      if (updatedItemIndex != -1) {
        itemData[updatedItemIndex]['qty_in_stock'] = newQuantity;
      }

      // Update the item in the database
      foodDisplay.updateQuantity(updatedItem['foodID'], newQuantity);

      // Update the table controller with the new data
      courseController.setNewData(itemData);
    }
  });
}


  // Function to delete the item at the specified index
  void _deleteItem(int index) {
    setState(() {
       if (index >= 0 && index < _foodItems.length) {
      // Remove the item from the _promoItems list
      var deletedItem = _foodItems.removeAt(index);
      print('deleteItem:  + $deletedItem');

      // for (int i = 0; i < _promoItems.length; i++) {
       
      // Remove the item from the itemData list
      itemData.removeWhere((item) =>
          item['foodID'] == deletedItem['foodID'] &&
          item['food_name'] == deletedItem['food_name'] &&
          item['stallID'] == deletedItem['stallID'] &&
          item['main_category'] == deletedItem['main_category'] &&
          item['sub_category'] == deletedItem['sub_category'] &&
          item['food_price'] == deletedItem['food_price'] &&
          item['qty_in_stock'] == deletedItem['qty_in_stock'] &&
          item['food_image'] == deletedItem['food_image']);
       
       // Delete the item from the database
      foodDisplay.deleteFood(deletedItem['foodID']);


      // Update the table controller with the new data
    courseController.setNewData(itemData);
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddFood())
                );
              },
              child: const Text('Add Food'),
            ),
            const SizedBox(height: 10), // Add some space between button and table
            Expanded(
              child: AdminTable(
                controller: courseController,
                fixedHeader: true,
              ),
            ),
          ],
        ),
      );
    });
  }
}