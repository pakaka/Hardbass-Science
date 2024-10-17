import requests
import sys
import time

def get_doi_and_title(query):
    base_url = "https://api.crossref.org/works"
    params = {
        "query": query,
        "rows": 1,
        "select": "DOI,title"
    }

    response = requests.get(base_url, params=params)
    
    if response.status_code == 200:
        data = response.json()
        items = data.get("message", {}).get("items", [])
        
        if items:
            item = items[0]
            return item.get("DOI"), item.get("title", [None])[0]
    
    return None, None

def main(article_query):
    # Get the DOI and title
    doi, title = get_doi_and_title(article_query)

    if doi and title:
        return doi, title
    else:
        return None, None

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python get_doi.py 'Your article query here'")
        sys.exit(1)

    # Get the article query from command-line argument
    article_query = " ".join(sys.argv[1:])
    
    doi, title = main(article_query)
    
    if doi and title:
        print(doi)
        print(title)
    else:
        print(f"No results found for the query: '{article_query}'")

# Export the functions
__all__ = ['get_doi_and_title', 'main']

