from flask import Flask, request, jsonify
import pandas as pd
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.preprocessing import OneHotEncoder
from sklearn.cluster import KMeans
from scipy.sparse import hstack

app = Flask(__name__)

# 🔹 Carica il dataset dei luoghi turistici
df = pd.read_csv("luoghi_napoli.csv")

# Aggiungi una colonna 'id' per evitare problemi
df.reset_index(inplace=True)
df.rename(columns={"index": "id"}, inplace=True)

# 🔹 Inizializza NLTK per la pulizia del testo
nltk.download('punkt')
nltk.download('wordnet')
nltk.download('stopwords')

stop_words = set(stopwords.words('italian'))
lemmatizer = WordNetLemmatizer()

def pulisci_testo(testo):
    parole = word_tokenize(str(testo).lower())
    parole_filtrate = [parola for parola in parole if parola.isalpha() and parola not in stop_words]
    parole_lemmi = [lemmatizer.lemmatize(parola) for parola in parole_filtrate]
    return " ".join(parole_lemmi)

df['descrizione_pulita'] = df['descrizione'].apply(pulisci_testo)

# 🔹 Creazione delle feature per il sistema di raccomandazione
tfidf = TfidfVectorizer()
desc_matrix = tfidf.fit_transform(df['descrizione_pulita'])

enc = OneHotEncoder()
cat_matrix = enc.fit_transform(df[['categoria', 'quartiere']])

X = hstack([desc_matrix, cat_matrix])

# 🔹 Addestramento del modello K-Means
n_clusters = 5  # Cambia il numero di cluster in base al dataset
kmeans = KMeans(n_clusters=n_clusters, random_state=42)
df['cluster'] = kmeans.fit_predict(X)

@app.route('/consiglia', methods=['GET'])
def consiglia():
    try:
        luogo_id = request.args.get('luogo_id', type=int)
        top_n = request.args.get('top_n', default=5, type=int)

        if luogo_id is None or luogo_id < 0 or luogo_id >= len(df):
            return jsonify({"error": "ID non valido"}), 400

        # 🔹 Trova il cluster del luogo selezionato
        cluster_id = df.loc[luogo_id, 'cluster']
        cluster_luoghi = df[df['cluster'] == cluster_id]

        # 🔹 Raccomanda i luoghi nello stesso cluster
        recommended_places = cluster_luoghi.copy()
        recommended_places = recommended_places[recommended_places.index != luogo_id].head(top_n)

        response = recommended_places[['id', 'nome', 'descrizione', 'tags', 'lat', 'lon']].to_dict(orient='records')

        return jsonify({"recommendations": response})

    except Exception as e:
        print(f"❌ Errore: {e}")
        return jsonify({"error": "Errore interno"}), 500

@app.route('/tutti_luoghi', methods=['GET'])
def tutti_luoghi():
    try:
        # 🔹 Ottieni tutti i luoghi nel dataset, inclusa la colonna 'id'
        response = df[['id', 'nome', 'descrizione', 'tags', 'lat', 'lon']].to_dict(orient='records')
        return jsonify({"all_places": response})
    except Exception as e:
        print(f"❌ Errore: {e}")
        return jsonify({"error": "Errore interno"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=10000, debug=True)
