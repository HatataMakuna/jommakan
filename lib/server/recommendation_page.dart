import 'package:flutter/material.dart';

import 'recommendation_system.dart';

class RecommendationPage extends StatelessWidget {
  final RecommendationSystem recommendationSystem;
  final int userId;

  const RecommendationPage({super.key, required this.recommendationSystem, required this.userId});

  @override
  Widget build(BuildContext context) {
    List<String> recommendations = recommendationSystem.recommendItems(userId);

    return ListView.builder(
      itemCount: recommendations.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(recommendations[index]),
        );
      },
    );
  }
}

void main() {
  RecommendationSystem recommendationSystem = RecommendationSystem();
  runApp(MaterialApp(home: RecommendationPage(recommendationSystem: recommendationSystem, userId: 1)));
}
