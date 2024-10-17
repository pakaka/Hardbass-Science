import requests

def get_doi_by_title(title):
    base_url = "https://api.crossref.org/works"
    params = {
        "query.title": title,
        "rows": 1,
        "select": "DOI,title"
    }

    response = requests.get(base_url, params=params)
    
    if response.status_code == 200:
        data = response.json()
        items = data.get("message", {}).get("items", [])
        
        if items:
            return items[0].get("DOI")
    
    return None

# Article title
article_title = "Denture hygiene practices: Recent updates from then to now"

# Get the DOI
doi = get_doi_by_title(article_title)

if doi:
    print(f"The DOI for the article '{article_title}' is: {doi}")
else:
    print(f"No DOI found for the article '{article_title}'")
