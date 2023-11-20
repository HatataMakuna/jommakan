import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:jom_makan/pages/Admin/store/name_random.dart';
import 'package:jom_makan/pages/Admin/views/base_views.dart';
import 'package:jom_makan/pages/Admin/views/filter_view.dart';
import 'package:jom_makan/pages/Admin/widgets/input/input.dart';
import 'package:jom_makan/pages/Admin/widgets/table/controller.dart';
import 'package:jom_makan/pages/Admin/widgets/table/table.dart';
import 'package:jom_makan/pages/Admin/widgets/table/table_item.dart';
import 'package:jom_makan/server/promotion.dart';

import '../../style/colors.dart';

import 'addPromotion.dart';

class UserList extends AdminView {
  UserList({super.key});

  @override
  State<StatefulWidget> createState() => _UserList();
}

class _UserList extends AdminStateView<UserList> {
  late AdminTableController _controller;
  final promotion _promotion = promotion();


 // Controller for text fields
  final TextEditingController _foodIdController = TextEditingController();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _foodPriceController = TextEditingController();
  final TextEditingController _foodPromotionController = TextEditingController();
  final TextEditingController _foodStallController = TextEditingController();
  final TextEditingController _foodDescriptionController = TextEditingController();

  var itemData = [];

  @override
  void initState() {
    // _fetchPromotion();
    NameRandom nameRandom = NameRandom();
    for (int i = 1; i <= 100; i++) {
      String formattedNumber = 'F${i.toString().padLeft(5, '0')}';
    print(formattedNumber);
      itemData.add({
        'id': formattedNumber,
        'name': nameRandom.getFoodName(),
        'six': "RM ${Random().nextInt(20)}",
        'addr': '四川省成都市',
        'id_type': "身份证",
        'reg_time': DateTime.now().toIso8601String(),
        'id_number': '123111111111111112',
        'phone': '18090555563',
        'course':"${Random().nextInt(20)}",
        'ip': '127.0.0.1'
      });
    }
    _controller = AdminTableController(items: [
      AdminTableItem(
          itemView: onItemView,
          width: 100,
          label: "Food ID",
          prop: 'id',
          fixed: FixedDirection.left),
      AdminTableItem(
          itemView: onItemView, width: 150, label: "Food Name", prop: 'name'),
      AdminTableItem(
          itemView: onItemView, width: 100, label: "Price", prop: 'six'),
      AdminTableItem(
          itemView: onItemView, width: 100, label: "Has Been Apply", prop: 'course'),
      AdminTableItem(
          itemView: onItemView, width: 200, label: "户籍", prop: 'addr'),
      AdminTableItem(
          itemView: onItemView, width: 200, label: "注册时间", prop: 'reg_time'),
      AdminTableItem(
          itemView: onItemView, width: 100, label: "身份证证件类型", prop: 'id_type'),
      AdminTableItem(
          itemView: onItemView, width: 200, label: "身份证件号码", prop: 'id_number'),
      AdminTableItem(
          itemView: onItemView, width: 100, label: "手机号码", prop: 'phone'),
      AdminTableItem(
          itemView: onItemView, width: 100, label: "登录IP", prop: 'ip'),
      AdminTableItem(
          itemView: onItemView, width: 100, label: "操作",fixed: FixedDirection.right,prop: 'action'),
    ]);
    _controller.setNewData(itemData);
    super.initState();
  }

  // void _fetchPromotion() async{
  //   var promotionData = await _promotion.getPromotion();
  //   if (promotionData['success']) {
  //     setState(() {
  //       _foodIdController.text = promotionData!['foodId'];
  //        _foodNameController.text = promotionData['foodName'];
  //         _foodPriceController.text = promotionData['foodPrice'];
  //          _foodPromotionController.text = promotionData['foodPromotion'];
  //           _foodStallController.text = promotionData['foodStall'];
  //            _foodDescriptionController.text = promotionData['foodDescription'];
  //     });
  //   }
  // }

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
              const Text("Check",style: TextStyle(color: Colors.blueAccent,fontSize: 15),),
              Container(width: 1,margin: const EdgeInsets.only(left:10,right: 10,top: 10,bottom: 10),color: Colors.black12,),
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
                MaterialPageRoute(builder: (context) => addPromotion()));
              },
              child: Text('Add Promotion'),
            ),
            SizedBox(height: 10), // Add some space between button and table
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