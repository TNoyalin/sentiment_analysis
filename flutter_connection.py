from flask import Flask, request, jsonify
import numpy as np
import pandas as pd
import csv
import re
import nltk
nltk.download('stopwords')
from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer
app = Flask(__name__)
from sklearn.feature_extraction.text import CountVectorizer
import pickle
import joblib
@app.route('/', methods = ['GET'])
def index():
    text = str(request.args['query'])
    data=[text]
    #data=['Happiness is when what you think, what you say, and what you do are in harmony.']
    #data = ["i found that with depression, one of the most important things you could realize is that you're not alone."]
    print(data)
    text=["Review"]
    with open('example.csv', 'w') as file:
        writer = csv.writer(file)
        writer.writerow(text)
        writer.writerow(data)
    dataset=pd.read_csv('example.csv', delimiter = '\t', quoting = 3)
    dataset.head()
    
    ps=PorterStemmer()
    all_stopwords=stopwords.words('english')
    all_stopwords.remove('not')
    corpus=[]
    for i in range(0,1):
        review=re.sub('[^a-zA-Z]',' ',dataset['Review'][i])
        review=review.lower()
        review=review.split()
        review=[ps.stem(word) for word in review if not word in set(all_stopwords)]
        review=' '.join(review)
        corpus.append(review)
        
    
    cvFile='C:/Users/noilen/Desktop/Project/Sample01/bow sentiment model.pkl'
    cv=pickle.load(open(cvFile,"rb"))
    X_fresh=cv.transform(corpus).toarray()
    X_fresh.shape
     
    classifier=joblib.load('C:/Users/noilen/Desktop/Project/Sample01/classifier sentiment model')
    y_pred=classifier.predict(X_fresh)
    print(y_pred)
    print(len(y_pred))
    d={}
    if (y_pred[0] == 1):
        d='😃Great, You are in good mood😃'
        return d
    else:
        d=' 👩‍❤️‍👩Let\'s go for a walk. 👩‍❤️‍👩 '
        return d

if __name__ =="__main__":
    app.run()