import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pre-order and Automation Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RewardsPage(),
    );
  }
}

class RewardsPage extends StatelessWidget {
  const RewardsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RewardCard(
            title: 'Your Rewards',
            description: 'Unlock delicious discounts and exclusive offers every time you dine with us.',
            validThrough: '12/2023',
            cardholderName: 'John Doe',
            rewardPoints: '500',
            onPressed: () {
              // Implement the action when the user taps the "Redeem Now" button
            },
          ),
          SizedBox(height: 16),
          TotalSpendUpgradeCard(
            totalSpent: 'RM 500.00',
            toUpgrade: 'RM 0.00',
          ),
        ],
      ),
    );
  }
}

class TotalSpendUpgradeCard extends StatelessWidget {
  final String totalSpent;
  final String toUpgrade;

  const TotalSpendUpgradeCard({
    required this.totalSpent,
    required this.toUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 5,
      child: Container(
        width: 300, // Adjust the width as needed
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Spent',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8),
                Text(
                  totalSpent,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'To Upgrade',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8),
                Text(
                  toUpgrade,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class RewardCard extends StatelessWidget {
  final String title;
  final String description;
  final String? validThrough;
  final String? cardholderName;
  final String? rewardPoints;
  final String? value;
  final VoidCallback? onPressed;

  const RewardCard({
    required this.title,
    required this.description,
    this.validThrough,
    this.cardholderName,
    this.rewardPoints,
    this.value,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 5,
      child: Container(
        width: 300, // Adjust the width as needed
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                if (onPressed != null)
                  ElevatedButton(
                    onPressed: onPressed,
                    child: Text('Redeem Now'),
                  ),
              ],
            ),
            Divider(),
            SizedBox(height: 8),
            Text(
              'Reward Description:',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            if (validThrough != null)
              SizedBox(height: 16),
            if (validThrough != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Valid Through:',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    validThrough!,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            if (cardholderName != null)
              SizedBox(height: 16),
            if (cardholderName != null)
              Text(
                'Cardholder Information',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            if (cardholderName != null)
              SizedBox(height: 8),
            if (cardholderName != null)
              Text(
                cardholderName!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            if (rewardPoints != null)
              SizedBox(height: 16),
            if (rewardPoints != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reward Points:',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    rewardPoints!,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            if (value != null)
              SizedBox(height: 16),
            if (value != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Value:',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    value!,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
