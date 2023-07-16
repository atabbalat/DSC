from flask import Flask, request, render_template
import pandas as pd
from scipy.sparse import csr_matrix
from sklearn.neighbors import NearestNeighbors

app = Flask(__name__)

# Load data
movies_df = pd.read_csv('Program\\App\\Data\\Movies.csv')  # replace with actual path
ratings_df = pd.read_csv('Program\\App\\Data\\Ratings.csv')  # replace with actual path

# Merge movies and ratings dataframes
df = pd.merge(ratings_df, movies_df, on='movieId')

# Filter to include only top 1000 most rated movies
top_movies = ratings_df.movieId.value_counts().index[:1000]
df = df[df.movieId.isin(top_movies)]

# Pivot and create movie-user matrix
movie_user_matrix = df.pivot(index='movieId', columns='userId', values='rating').fillna(0)

# Create mapper from movie title to index
hashmap = {
    movie: i for i, movie in enumerate(
        list(movies_df.set_index('movieId').loc[movie_user_matrix.index].title)
    )
}

# Transform the matrix to scipy sparse matrix
movie_user_matrix_sparse = csr_matrix(movie_user_matrix.values)

# Fit the model
model_knn = NearestNeighbors(
    metric='cosine',
    algorithm='brute',
    n_neighbors=20,
    n_jobs=-1
)
model_knn.fit(movie_user_matrix_sparse)


@app.route('/', methods=['GET'])
def index():
    return render_template('index.html')

@app.route('/recommend', methods=['GET', 'POST'])
def recommend():
    if request.method == 'POST':
        movie_name = request.form['movieName']
        num_recommendations = request.form.get('numRecommendations', 10)

        # Get corresponding movie id
        idx = [hashmap[key] for key in hashmap if movie_name.lower() in key.lower()]

        if idx[0]:
            distances, indices = model_knn.kneighbors(
                movie_user_matrix_sparse[idx[0]],
                n_neighbors=int(num_recommendations) + 1
            )

            raw_recommends = sorted(
                    list(
                        zip(
                            indices.squeeze().tolist(),
                            distances.squeeze().tolist()
                        )
                    ),
                    key=lambda x: x[1]
                )[:0:-1]

            # Get movie titles
            reverse_hashmap = {v: k for k, v in hashmap.items()}
            recommendations = [reverse_hashmap[i[0]] for i in raw_recommends]
        else:
            recommendations = ['Sorry that title does not exists']

        return render_template('results.html', recommendations=recommendations)
    else:
        return render_template('results.html')


if __name__ == '__main__':
    app.run(debug=True)