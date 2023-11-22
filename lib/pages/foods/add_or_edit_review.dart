import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jom_makan/server/food/add_modify_review.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

class AddReviewPage extends StatefulWidget {
  final Map<String, dynamic>? currentUserReview;
  final Map<String, dynamic> selectedFood;

  const AddReviewPage({
    super.key,
    required this.currentUserReview,
    required this.selectedFood,
  });

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  double rating = 0.0;
  TextEditingController descriptionController = TextEditingController();
  final AddOrModifyReview _addOrModifyReview = AddOrModifyReview();

  @override
  void initState() {
    super.initState();
    // Pre-fill existing review details if available
    if (widget.currentUserReview != null) {
      // Pre-fill the fields if any of them are not null
      if (widget.currentUserReview!['stars'] != null) {
        rating = double.parse(widget.currentUserReview?['stars']);
      }
      
      if (widget.currentUserReview!['description'] != null) {
        descriptionController.text = widget.currentUserReview!['description'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Add / Modify Review',
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
                    image: AssetImage('images/foods/' + widget.selectedFood['food_image']),
                    fit: BoxFit.cover,
                  )
                ),
                const SizedBox(height: 16),
                loadTitle(),
                const SizedBox(height: 16),
                reviewFields(),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadTitle() {
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
      ),
    );
  }

  Widget reviewFields() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RatingBar.builder(
            initialRating: rating,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 40,
            unratedColor: Colors.grey,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            onRatingUpdate: (newRating) {
              setState(() {
                rating = newRating;
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Review Description',
              hintText: 'Write your review here...',
            ),
            maxLines: 4,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Save Review?'),
                    content: const Text('Are you sure you want to save your review?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Register'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          saveReview();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Submit Review'),
          ),
        ],
      ),
    );
  }

  void saveReview() async {
    bool isSuccess;

    // rating has been defined as double in 
    String? description = descriptionController.text;

    // Check whether the user has an existing review
    if (widget.currentUserReview != null) {
      // If yes, call the modify review logic
      isSuccess = await _addOrModifyReview.updateReview(
        rating, description, int.parse(widget.currentUserReview!['ratingID'])
      );
    } else {
      // If no, call the add review logic
      isSuccess = await _addOrModifyReview.addReview(
        int.parse(widget.selectedFood['foodID']),
        Provider.of<UserProvider>(context, listen: false).userID!,
        rating, description
      );
    }

    // Show message whether the review has been saved successfully
    if (isSuccess) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Your review has been saved successfully'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sorry'),
            content: const Text(
              'There is an error while we\'re trying to save your review. Please try again later.'
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
