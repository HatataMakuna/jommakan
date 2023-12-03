import 'package:flutter/material.dart';
import 'package:jom_makan/components/rating/get_average_ratings.dart';
import 'package:jom_makan/pages/foods/food_reviews.dart';
import 'package:jom_makan/server/cart/add_to_cart.dart';
import 'package:jom_makan/server/food/get_foods.dart';
import 'package:jom_makan/server/views/update_views.dart';
import 'package:jom_makan/stores/favorites_provider.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

class FoodDetailsPage extends StatefulWidget {
  final Map<String, dynamic> selectedFood;

  const FoodDetailsPage({super.key, required this.selectedFood});

  @override
  State<StatefulWidget> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  final GetFoods _getFoods = GetFoods();
  final GetAverageRatings _getAvgRatings = GetAverageRatings();
  int quantity = 1;
  String notes = '';
  double averageRating = 0.0; // Initialize averageRating
  int noRatings = 0;
  List<String> preferences = [];
  double totalPrice = 0.0;
  List<String> foodCategory = [];

  @override
  void initState() {
    super.initState();

    // Update view count once a user enters the specific food details
    _updateViewCount();

    // To get average ratings directly
    _getAverageRatings();
    _getNoOfRatings();

    // Calculate initial total price
    _calculateTotalPrice();

    _fetchCategory();
  }

  void _updateViewCount() {
    UpdateViews.updateViewCount(int.parse(widget.selectedFood['foodID']));
  }

  // Function to get average ratings and update the state
  void _getAverageRatings() async {
    double rating = await _getAvgRatings.setAverageRating(int.parse(widget.selectedFood['foodID']));
    setState(() {
      averageRating = rating;
    });
  }

  void _getNoOfRatings() async {
    int numberOfRatings = await _getAvgRatings.setNoRatings(int.parse(widget.selectedFood['foodID']));
    setState(() {
      noRatings = numberOfRatings;
    });
  }

  // Calculate total price based on quantity and food price
  void _calculateTotalPrice() {
    setState(() {
      totalPrice = quantity * double.parse(widget.selectedFood['food_price']);
    });
  }

  void _fetchCategory() async {
    Map<String, dynamic> categories = await _getFoods.getCategoryNameByFoodID(int.parse(widget.selectedFood['foodID']));
    //print(categories);
    List<String> category = [];

    if (categories['main_category'] != null) {
      category.add(categories['main_category']);
    }
    if (categories['sub_category'] != null) {
      category.add(categories['sub_category']);
    }

    if (mounted) {
      setState(() {
        foodCategory = category;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.selectedFood['food_name'],
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints.expand(height: 250),
                child: Image(
                  image: AssetImage('images/foods/${widget.selectedFood['food_image']}'),
                  fit: BoxFit.cover,
                )
              ),
              const SizedBox(height: 16),
              titleRating(),
              // quantity
              const SizedBox(height: 16),
              adjustQuantity(),
              const SizedBox(height: 16),
              buildPreferencesCheckboxes(),
              const SizedBox(height: 16),
              buildAdditionalNotesTextField(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Replace this with your logic to add the item to the cart
                  addToCart();
                },
                child: Text('Add to Cart - RM${totalPrice.toStringAsFixed(2)}'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleRating() {
    FavoritesProvider favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    int userID = Provider.of<UserProvider>(context, listen: false).userID!;

    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    // Category tags
                    Tags(
                      spacing: 8,
                      itemCount: foodCategory.length,
                      itemBuilder: (index) {
                        final item = foodCategory[index];

                        return ItemTags(
                          key: Key(index.toString()),
                          index: index,
                          title: item,
                          textStyle: const TextStyle(fontSize: 12),
                          combine: ItemTagsCombine.withTextBefore,
                          activeColor: Colors.blue,
                          splashColor: Colors.lightBlue,
                          onPressed: null,
                        );
                      }
                    ),
                    const SizedBox(width: 8),
                    // Stall name tag
                    Tags(
                      spacing: 8,
                      itemCount: 1,
                      itemBuilder: (index) {
                        return ItemTags(
                          key: Key(index.toString()),
                          index: index,
                          title: widget.selectedFood['stall_name'],
                          textStyle: const TextStyle(fontSize: 12),
                          combine: ItemTagsCombine.withTextBefore,
                          activeColor: Colors.green,
                          splashColor: Colors.lightGreen,
                          onPressed: null,
                        );
                      }
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: Icon(
                    favoritesProvider.isFavorite(int.parse(widget.selectedFood['foodID']))
                      ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    String status = await favoritesProvider.toggleFavorite(int.parse(widget.selectedFood['foodID']), userID);
                    setState(() {});
                    showSnackbarMessage(status);
                  }
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    '${widget.selectedFood['food_name']} - ${widget.selectedFood['stall_name']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodReviewsPage(selectedFood: widget.selectedFood),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Average Rating: ',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    averageRating.toStringAsFixed(2),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                  const Text(
                    ' / 5.00 from ',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    noRatings.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                  const Text(
                    ' rating(s)',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'RM ',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  double.parse(widget.selectedFood['food_price']).toStringAsFixed(2),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showSnackbarMessage(String status) {
    switch (status) {
      case 'add success':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Food added to favorites.'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      case 'add failure':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error while adding food to favorites. Try again later.'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      case 'remove success':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Food removed from favorites.'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      case 'remove failure':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error while removing food from favorites. Try again later.'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unknown error occurred. Try again later.'),
            duration: Duration(seconds: 2),
          ),
        );
    }
  }

  Widget adjustQuantity() {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Quantity',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                        _calculateTotalPrice();
                      });
                    }
                  }
                ),
                const SizedBox(width: 8),
                Text(quantity.toString()),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                      _calculateTotalPrice();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPreferencesCheckboxes() {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preferences:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            buildCheckbox('No vegetarian', 'no vegetarian'),
            buildCheckbox('Extra vegetarian', 'extra vegetarian'),
            buildCheckbox('No Spicy', 'no spicy'),
            buildCheckbox('Extra Spicy', 'extra spicy'),
          ],
        ),
      ),
    );
  }

  Widget buildCheckbox(String title, String preference) {
    return Row(
      children: [
        Checkbox(
          value: preferences.contains(preference),
          onChanged: (bool? value) {
            setState(() {
              if (value != null && value) {
                preferences.add(preference);
              } else {
                preferences.remove(preference);
              }
            });
          },
        ),
        const SizedBox(width: 5),
        Text(title),
      ],
    );
  }

  Widget buildAdditionalNotesTextField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Additional Notes (optional)',
        hintText: 'Add special instructions...',
      ),
      onChanged: (value) {
        setState(() {
          notes = value;
        });
      },
    );
  }

  void addCartConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Add to Cart?'),
          content: const Text('Are you sure you want to add this food item to cart?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                addToCart();
              },
            ),
          ],
        );
      }
    );
  }

  void addToCart() async {
    AddToCart addToCart = AddToCart();

    bool addToCartResult = await addToCart.addToCart(
      userID: Provider.of<UserProvider>(context, listen: false).userID!, // replace with the actual user ID
      foodID: int.parse(widget.selectedFood['foodID']), // replace with the actual food ID
      quantity: quantity,
      noVege: preferences.contains('no vegetarian'),
      extraVege: preferences.contains('extra vegetarian'),
      noSpicy: preferences.contains('no spicy'),
      extraSpicy: preferences.contains('extra spicy'),
      notes: notes,
    );

    showStatusMessage(addToCartResult);
  }

  void showStatusMessage(bool result) {
    if (result) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Your food item has been successfully added to cart!'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        }
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sorry'),
            content: const Text('There was an error while trying to add food to cart. Please try again later.'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        }
      );
    }
  }
}