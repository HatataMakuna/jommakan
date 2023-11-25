import 'package:flutter/material.dart';
//import 'package:jom_makan/pages/admin/store/name_random.dart';
import 'package:jom_makan/pages/admin/views/base_views.dart';
import 'package:jom_makan/pages/admin/views/user/add_promotion.dart';
import 'package:jom_makan/pages/admin/widgets/table/controller.dart';
import 'package:jom_makan/pages/admin/widgets/table/table.dart';
import 'package:jom_makan/pages/admin/widgets/table/table_item.dart';
import 'package:jom_makan/server/promotion.dart';
import 'package:jom_makan/pages/Admin/style/colors.dart';

class UserList extends AdminView {
  UserList({super.key});

  @override
  State<StatefulWidget> createState() => _UserList();
}

class _UserList extends AdminStateView<UserList> {
  late AdminTableController _controller;
  final Promotion _promotion = Promotion();

  // Controller for text fields
  final TextEditingController _foodIdController = TextEditingController();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _foodPriceController = TextEditingController();
  final TextEditingController _foodPromotionController = TextEditingController();
  final TextEditingController _foodStallController = TextEditingController();
  final TextEditingController _foodDescriptionController = TextEditingController();

  var itemData = [];
  final Promotion promo = Promotion();
  List<Map<String, dynamic>> _promoItems = [];

    @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    try {
      final data = await promo.getPromotionData();

      setState(() {
        _promoItems = data;

        // Move the logic inside setState after _promoItems has been updated
        //NameRandom nameRandom = NameRandom();

        for (int i = 0; i < _promoItems.length; i++) {
          String foodNameCorrect = 'foodName: ${_promoItems[i]['foodName']}';
          print('Food Name: ' + foodNameCorrect);

          itemData.add({
            'foodId': _promoItems[i]['foodID'],
            'foodName': _promoItems[i]['foodName'],
            'foodPrice': _promoItems[i]['foodPrice'],
            'foodPromotion': _promoItems[i]['foodPromotion'],
            'foodStall': _promoItems[i]['foodStall'],
            'foodDescription': _promoItems[i]['foodDescription'],
          });
        }

        _controller = AdminTableController(items: [
          AdminTableItem(
              itemView: onItemView,
              width: 100,
              label: "Food ID",
              prop: 'foodId',
              fixed: FixedDirection.left),
          AdminTableItem(
            itemView: onItemView,
            width: 150,
            label: "Food Name",
            prop: 'foodName',
          ),
          AdminTableItem(
              itemView: onItemView,
              width: 100,
              label: "Food Price",
              prop: 'foodPrice'),
          AdminTableItem(
              itemView: onItemView,
              width: 200,
              label: "Food Promotion",
              prop: 'foodPromotion'),
          AdminTableItem(
              itemView: onItemView,
              width: 200,
              label: "Food Stall",
              prop: 'foodStall'),
          AdminTableItem(
              itemView: onItemView,
              width: 100,
              label: "Food Description",
              prop: 'foodDescription'),
          AdminTableItem(
              itemView: onItemView,
              width: 100,
              label: "操作",
              fixed: FixedDirection.right,
              prop: 'action'),
        ]);
        _controller.setNewData(itemData);
      });
    } catch (e) {
      print('Error loading promotion data: $e');
    }
  }
  
  Future<void> _promotionDisplay() async {
    try {
      //final promotion = await _promotion.getPromotionData();
      setState(promotionData) {
        _foodIdController.text = promotionData['foodId'];
        _foodNameController.text = promotionData['foodName'];
        _foodPriceController.text = promotionData['foodPrice'];
        _foodPromotionController.text = promotionData['foodPromotion'];
        _foodStallController.text = promotionData['foodStall'];
        _foodDescriptionController.text = promotionData['foodDescription'];
      }
    } catch (error) {
      print('Error loading cart items: $error');
      // Handle the error as needed
    }
  }
  Widget onItemView(
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
      if(item.prop == 'action'){
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
              const Text("More",style: TextStyle(color: Colors.blueAccent,fontSize: 15),),
            ],
          ),
        );
      }
      return Container(
        alignment: Alignment.center,
        child: Text(
          "${_controller.ofData(index)[item.prop!]}",
          style: TextStyle(color: AdminColors().get().secondaryColor),
        ),
      );
    }
  }

 // Function to delete the item at the specified index
  void _deleteItem(int index) {
    setState(() {
       if (index >= 0 && index < _promoItems.length) {
      // Remove the item from the _promoItems list
      var deletedItem = _promoItems.removeAt(index);
print('deleteItem:  + $deletedItem');

      // for (int i = 0; i < _promoItems.length; i++) {
       
      // Remove the item from the itemData list
      itemData.removeWhere((item) =>
          item['foodId'] == deletedItem['foodID'] &&
          item['foodName'] == deletedItem['foodName'] &&
          item['foodPrice'] == deletedItem['foodPrice'] &&
          item['foodPromotion'] == deletedItem['foodPromotion'] &&
          item['foodStall'] == deletedItem['foodStall'] &&
          item['foodDescription'] == deletedItem['foodDescription']);
       
       // Delete the item from the database
      _promotion.deletePromotion(deletedItem['foodID']);


      // Update the table controller with the new data
      _controller.setNewData(itemData);
      }
    });
  }

  

  @override
  Widget buildForLarge(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Container(
        width: size.maxWidth,
        margin: const EdgeInsets.all(10),
        height: size.maxHeight,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                 // Navigate to a new page when the button is pressed
                Navigator.push(
                 context,
                MaterialPageRoute(builder: (context) => AddPromotion()));
              },
              child: const Text('Add Promotion'),
            ),
            const SizedBox(height: 10), // Add some space between button and table
            Expanded(
              child: AdminTable(
                controller: _controller,
                fixedHeader: true,
              ),
            ),
          ],
        ),
      );
    });
  }
}