import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jom_makan/pages/Admin/store/name_random.dart';
import 'package:jom_makan/pages/Admin/views/base_views.dart';
import 'package:jom_makan/pages/Admin/views/stall/add_stall.dart';
import 'package:jom_makan/pages/Admin/widgets/button/style.dart';
import 'package:jom_makan/pages/Admin/widgets/table/controller.dart';
import 'package:jom_makan/pages/Admin/widgets/table/table_item.dart';
import 'package:jom_makan/pages/Admin/widgets/tag/tag.dart';
import 'package:jom_makan/server/renewStall/renew.dart';

import '../../style/colors.dart';
import '../../widgets/table/table.dart';

class RenewStallView extends AdminView {
  RenewStallView({super.key});

  @override
  State<StatefulWidget> createState() => RenewStallPage();
}

class RenewStallPage extends AdminStateView<RenewStallView> {
  late AdminTableController _renewController; // Corrected variable name
  var itemData = [];
  final Renew renewStall = Renew();
  List<Map<String, dynamic>> _renewItem = [];

  @override
  void initState() {
    super.initState();
    _renewController = AdminTableController(items: []);
    _getData();
  }

  Widget renewStallView(BuildContext context, int index, dynamic data,
      AdminTableItem item) {
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
       
        child: const Text(
          "Update",
          style: TextStyle(color: Colors.red, fontSize: 15),
        ),
      ),
        ],
          ),
        );
      }
      if(item.prop == 'state'){
          return Container(
            alignment: Alignment.center,
            child: TagView(data[item.prop!], type: AdminButtonType.primary,size: AdminButtonSize.mini,),
          );
        }
      return Container(
        alignment: Alignment.center,
        child: Text(
          "${_renewController.ofData(index)[item.prop!]}",
          style: TextStyle(color: AdminColors()
              .get()
              .secondaryColor),
        ),
      );
    }
      }

  void _getData()  async{
    try {
      final data = await renewStall.getRenewData();
      final state = ['Processing', 'Approve', 'Reject'];

      setState(() {
        _renewItem = data;

         // Clear the existing data
      itemData.clear();

        for (int i = 0; i < _renewItem.length; i++) {
          String foodNameCorrect = 'foodName: ${_renewItem[i]['stallName']}';
          print('Food Name: ' + foodNameCorrect);
          int stateIndex = Random().nextInt(3);

          itemData.add({
            'stallID': _renewItem[i]['stallID'],
            'stallName': _renewItem[i]['stallName'],
            'stallOwner': _renewItem[i]['stallOwner'],
            'totalStaff': _renewItem[i]['totalStaff'],
            'canteen': _renewItem[i]['canteen'],
            'state': state[stateIndex],
          });
        }

    _renewController = AdminTableController(items: [
      AdminTableItem(
        itemView: renewStallView,
        width: 150,
        label: 'Stall ID',
        prop: 'stallID',
         fixed: FixedDirection.left
      ),
      AdminTableItem(
        itemView: renewStallView,
        width: 300,
        label: 'Stall Name',
        prop: 'stallName',
      ),
      AdminTableItem(
        itemView: renewStallView,
        width: 150,
        label: 'Stall Owner',
        prop: 'stallOwner',
      ),
      AdminTableItem(
        itemView: renewStallView,
        width: 150,
        label: 'Total Staff',
        prop: 'totalStaff',
      ),
      AdminTableItem(
        itemView: renewStallView,
        width: 150,
        label: 'Canteen',
        prop: 'canteen',
      ),
      AdminTableItem(
          itemView: renewStallView,
          width: 200,
          label: 'Approve',
          prop: 'state'),
         AdminTableItem(
              itemView: renewStallView,
              width: 150,
              label: "More",
              fixed: FixedDirection.right,
              prop: 'action'
      ),
    ]);

    _renewController.setNewData(itemData);
  });
    } catch (e) {
      print('Error loading Admin data: $e');
    }
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
                  MaterialPageRoute(builder: (context) => const AddStall())
                );
              },
              child: const Text('Renew Stall Now'),
            ),
            const SizedBox(height: 10), // Add some space between button and table
            Expanded(
              child: AdminTable(
                controller: _renewController,
                fixedHeader: true,
              ),
            ),
          ],
        ),
      );
    });
  }


  // Function to delete the item at the specified index
  void _deleteItem(int index) {
    setState(() {
       if (index >= 0 && index < _renewItem.length) {
      // Remove the item from the _promoItems list
      var deletedItem = _renewItem.removeAt(index);
      print('deleteItem:  + $deletedItem');

      // for (int i = 0; i < _promoItems.length; i++) {
       
      // Remove the item from the itemData list
      itemData.removeWhere((item) =>
          item['stallID'] == deletedItem['stallID'] &&
          item['stallName'] == deletedItem['stallName'] &&
          item['canteen'] == deletedItem['canteen']);
       
       // Delete the item from the database
      renewStall.deleteRenew(deletedItem['stallID']);


      // Update the table controller with the new data
    _renewController.setNewData(itemData);
      }
    });
  }
}
