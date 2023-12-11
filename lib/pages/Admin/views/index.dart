import 'package:flutter/material.dart';
import 'package:jom_makan/pages/Admin/style/colors.dart';
import 'package:jom_makan/pages/Admin/views/base_views.dart';
import 'package:jom_makan/pages/Admin/widgets/table/controller.dart';
import 'package:jom_makan/pages/Admin/widgets/table/table.dart';
import 'package:jom_makan/pages/Admin/widgets/table/table_item.dart';
import 'package:jom_makan/server/food/food.dart';

class IndexView extends AdminView {
  IndexView({super.key});

  @override
  State<StatefulWidget> createState() => _IndexView();
}

class _IndexView extends AdminStateView<IndexView> {
  late AdminTableController<dynamic> controller;
  var itemData = [];
  final Food foodDisplay = Food();
  List<Map<String, dynamic>> _foodItems = [];

  @override
  void initState() {
    super.initState();
    controller = AdminTableController<dynamic>(items: []);
    _getData();
  }
  
  Widget itemView(
    BuildContext context, int index, dynamic data,
    AdminTableItem<dynamic> item
  ) {
    if (index == -1) {
      return Container(
        alignment: Alignment.center,
        child: Text(item.label,style: TextStyle(color: AdminColors().get().secondaryColor),),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Text(
          "${controller.ofData(index)[item.prop!]}",
          style: TextStyle(color: AdminColors()
              .get()
              .secondaryColor),
        ),
      );
    }
  }

  void _getData() async {
    try {
      final data = await foodDisplay.getFoodData();

      setState(() {
        _foodItems = data;

        // Sort the _foodItems list by the 'views' column in descending order
        _foodItems.sort(
          (a, b) => int.parse(b['views'].toString()).compareTo(int.parse(a['views'].toString()))
        );

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
          'views': item['views'],
        };
      }).toList();

    controller = AdminTableController(items: [
      AdminTableItem<dynamic>(
          itemView: itemView,
          width: 130,
           label: "Food ID",
              prop: 'foodID',
          ),
          AdminTableItem<dynamic>(
            itemView: itemView,
            width: 200,
            label: "Food Name",
            prop: 'foodName',
            fixed: FixedDirection.left
          ),
      AdminTableItem<dynamic>(
            itemView: itemView,
            width: 150,
            label: "Stall ID",
            prop: 'stallID',
          ),
          AdminTableItem<dynamic>(
            itemView: itemView,
            width: 150,
            label: "Main Category",
            prop: 'mainCategory',
          ),
          AdminTableItem<dynamic>(
            itemView: itemView,
            width: 150,
            label: "Sub Category",
            prop: 'subCategory',
          ),
          AdminTableItem<dynamic>(
              itemView: itemView,
              width: 100,
              label: "Food Price",
              prop: 'foodPrice'),
          AdminTableItem<dynamic>(
              itemView: itemView,
              width: 200,
              label: "Quantity",
              prop: 'qtyInStock'),
          AdminTableItem<dynamic>(
              itemView: itemView,
              width: 200,
              label: "Food Image",
              prop: 'foodImage'),
          AdminTableItem<dynamic>(
              itemView: itemView,
              width: 200,
              label: "View",
              fixed: FixedDirection.right,
              prop: 'views'),
        ]);
    controller.setNewData(itemData);
     });
    } catch (e) {
      print('Error loading View data: $e');
    }
  }

  @override
  Widget? buildForLarge(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: AdminTable<dynamic>(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        controller: controller,
        fixedHeader: true,
      ),
    );
  }
}
