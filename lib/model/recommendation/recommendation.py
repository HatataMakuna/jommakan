# Install the 'surprise' library if you haven't already
# pip install scikit-surprise

import pandas as pd
from surprise import Dataset
from surprise import Reader
from surprise.model_selection import train_test_split
from surprise import KNNBasic
from surprise import accuracy

# Assuming you have a DataFrame 'ratings_df' with columns 'userID', 'foodID', 'rating'
# This DataFrame should contain user ratings for different foods

# Define the reader
reader = Reader(rating_scale=(0, 5))

# Load the data into the Surprise dataset
data = Dataset.load_from_df(ratings_df[['userID', 'foodID', 'rating']], reader)

# Split the data into training and testing sets
trainset, testset = train_test_split(data, test_size=0.2, random_state=42)

# Use User-based Collaborative Filtering
sim_options = {
    'name': 'cosine',
    'user_based': True
}

# Initialize the model
model = KNNBasic(sim_options=sim_options)

# Train the model on the training set
model.fit(trainset)

# Make predictions on the test set
predictions = model.test(testset)

# Evaluate the model
accuracy.rmse(predictions)

# Function to get food recommendations for a given user
def get_top_n_recommendations(predictions, n=10):
    top_n = {}
    for uid, iid, true_r, est, _ in predictions:
        if est >= 3.0:  # Consider only high-rated predictions
            if uid not in top_n:
                top_n[uid] = []
            top_n[uid].append((iid, est))

    # Sort the predictions for each user and get the top N
    for uid, user_ratings in top_n.items():
        user_ratings.sort(key=lambda x: x[1], reverse=True)
        top_n[uid] = user_ratings[:n]

    return top_n

# Get recommendations for a specific user
user_id_to_recommend = 1
user_top_n = get_top_n_recommendations(predictions, n=5)
print(f"Top 5 recommendations for user {user_id_to_recommend}: {user_top_n[user_id_to_recommend]}")
