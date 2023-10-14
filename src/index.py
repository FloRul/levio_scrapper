import json
import requests
from bs4 import BeautifulSoup
import boto3

def lambda_handler(event, context):
    try:
        # Define the URL you want to scrape
        url_to_scrape = "https://example.com"

        # Send an HTTP GET request to the URL
        response = requests.get(url_to_scrape)
        response.raise_for_status()

        # Create a BeautifulSoup object to parse the HTML content
        soup = BeautifulSoup(response.text, "html.parser")

        # Find all anchor tags (links) in the HTML
        links = soup.find_all("a")

        # Initialize a list to store textual content
        textual_content = []

        # Parse and filter the links
        for link in links:
            # Extract and store textual content
            text = link.get_text()
            if text:
                textual_content.append(text)

        # Store textual content in a .txt file
        text_to_store = "\n".join(textual_content)
        s3 = boto3.client('s3')
        bucket_name = 'amazon-connect-753032b15c4c'  # Replace with your S3 bucket name
        file_key = 'scraping_tests/scraped_text.txt'  # Replace with your desired file name

        s3.put_object(Bucket=bucket_name, Key=file_key, Body=text_to_store)

        # Return a response with the S3 bucket and file information
        response_data = {
            "bucket_name": bucket_name,
            "file_key": file_key,
            "textual_content_count": len(textual_content)
        }

        return {
            "statusCode": 200,
            "body": json.dumps(response_data)
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
