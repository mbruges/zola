import chromadb
import openai
from chromadb.config import DEFAULT_TENANT, DEFAULT_DATABASE, Settings
from transformers import AutoTokenizer, AutoModel
import torch
import json
openai.api_key = "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"
model_name = "sentence-transformers/all-MiniLM-L6-v2"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModel.from_pretrained(model_name)
client = chromadb.PersistentClient(
    path="chroma_openai",
    settings=Settings(),
    tenant=DEFAULT_TENANT,
    database=DEFAULT_DATABASE,
)

collection_name = "books_collection"


def buildDB():
    collection = client.create_collection(collection_name)

    # Load book data from JSON file
    with open('database.json', 'r') as file:
        books = json.load(file)

    # Convert tags list to a string
    for book in books:
        book["tags"] = ", ".join(book["tags"])

    # Create embeddings for each book
    book_embeddings = openai_embeddings([book["blurb"] + " " + book["title"] for book in books])

    # Generate unique IDs (e.g., using ISBN)
    ids = [str(book["isbn"]) for book in books]  # Ensure IDs are strings

    for book, embedding, id in zip(books, book_embeddings, ids):
        collection.add(
            ids=[id],
            documents=[book["blurb"]],
            metadatas=[book],  # Store the modified book entry
            embeddings=[embedding]
        )
    return collection

# Function to create embeddings
def create_embeddings(texts):
    inputs = tokenizer(texts, padding=True, truncation=True, return_tensors="pt")
    with torch.no_grad():
        embeddings = model(**inputs).last_hidden_state[:, 0, :]
    return embeddings.numpy()


def openai_embeddings(texts):
    print(f"using openai for {texts}")
    response = openai.Embedding.create(
            model="text-embedding-3-small",
            input=texts
        )
    embeddings = [item["embedding"] for item in response["data"]]
    return embeddings

# Set up the querying function
def query_books(search_term):
    #search_embedding = create_embeddings([search_term])
    search_embedding = openai_embeddings([search_term])
    search_results = collection.query(
        query_embeddings=search_embedding,
        n_results=3  # Adjust to your needs
    )
    index = 0
    refined_results = []
    for entry in search_results['metadatas'][0]:
        result = {
            "title" : entry['title'],
            "author" : entry['author'],
            "blurb" : entry['blurb'],
            "distance" : search_results['distances'][0][index]
        }
        if int(result['distance']) < 1.1:
            refined_results.append(result)
            print(result)
        index += 1
    return refined_results

try:
    collection = client.get_collection(collection_name)
except:
   print("Need to build collection")

# Example usage of the query function
search_results = query_books('facts about pirates')
