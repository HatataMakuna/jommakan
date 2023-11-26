import 'package:flutter/material.dart';
import 'package:jom_makan/components/rating/get_average_ratings.dart';
import 'package:jom_makan/pages/foods/add_or_edit_review.dart';
import 'package:jom_makan/server/rating/get_ratings.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FoodReviewsPage extends StatefulWidget {
  final Map<String, dynamic> selectedFood;

  const FoodReviewsPage({super.key, required this.selectedFood});

  @override
  State<StatefulWidget> createState() => _FoodReviewsPageState();
}

class _FoodReviewsPageState extends State<FoodReviewsPage> {
  final GetAverageRatings _getAvgRatings = GetAverageRatings();
  final FoodRatings _foodRatings = FoodRatings();
  double averageRating = 0.0;
  int noRatings = 0;
  List<Map<String, dynamic>> userReviews = [];
  
  @override
  void initState() {
    super.initState();
    _getAverageRatings();
    _getNoOfRatings();
    _getUserReviews();
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

  void _getUserReviews() async {
    List<Map<String, dynamic>> reviews = await _foodRatings.getUserReviews(
      int.parse(widget.selectedFood['foodID']),
      Provider.of<UserProvider>(context, listen: false).userID!,
    );
    
    setState(() {
      userReviews = reviews;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Ratings and Reviews',
          style: TextStyle(color: Colors.black),
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
              // food image
              Container(
                constraints: const BoxConstraints.expand(height: 250),
                child: Image(
                  image: AssetImage('images/foods/${widget.selectedFood['food_image']}'),
                  fit: BoxFit.cover,
                )
              ),
              const SizedBox(height: 16),
              // food title and overall ratings
              titleRating(),
              const SizedBox(height: 16),
              // display each user rating and description
            ],
          ),
        ),
      ),
    );
  }

  Widget titleRating() {
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
            Row(
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final currentUserReview = await _foodRatings.getCurrentUserReview(
                  int.parse(widget.selectedFood['foodID']),
                  Provider.of<UserProvider>(context, listen: false).userID!,
                );

                goToAddReviewPage(currentUserReview);
              },
              child: const Text('Add / Modify a review'),
            ),
            const SizedBox(height: 16),
            getUserReviews(),
          ],
        ),
      ),
    );
  }

  void goToAddReviewPage(Map<String, dynamic>? userReview) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddReviewPage(
          currentUserReview: userReview,
          selectedFood: widget.selectedFood,
        ),
      ),
    );
  }

  Widget getUserReviews() {
    return userReviews.isEmpty ? const Center(child: Text('No reviews yet'))
    // ignore: sized_box_for_whitespace
    : Container(
      height: 300,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: userReviews.length,
        itemBuilder: (context, index) {
          final reviewItem = userReviews[index];

          // Null-aware checks
          final username = reviewItem['username'] ?? 'Unknown User';
          final description = reviewItem['description'] ?? 'No description';

          return ListTile(
            title: Text(username),
            subtitle: Text(description),
            trailing: RatingBar.builder(
              initialRating: double.parse(reviewItem['stars']),
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              unratedColor: Colors.grey,
              itemSize: 20,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              onRatingUpdate: (rating) {},
              ignoreGestures: true,
            ),
          );
        },
      ),
    );
  }
}