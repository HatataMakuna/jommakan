// Example of Collaborative Filtering
class RecommendationSystem {
  Map<int, List<String>> userPreferences = {
    1: ['Pizza', 'Burger', 'Sushi'],
    2: ['Salad', 'Burger', 'Pizza'],
    // Add more user preferences here
  };

  List<String> recommendItems(int userId) {
    // Implement recommendation logic based on user preferences
    // Return a list of recommended items
    // Example: ['Sushi', 'Salad', 'Burger']
    return userPreferences[userId] ?? [];
  }
}
