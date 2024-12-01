import os
from bs4 import BeautifulSoup
from datetime import datetime

def extract_meta_data(directory):
    index_list = []

    for filename in os.listdir(directory):
        if filename.endswith('.html'):
            file_path = os.path.join(directory, filename)
            with open(file_path, 'r', encoding='utf-8') as file:
                soup = BeautifulSoup(file, 'html.parser')
                title = soup.title.string if soup.title else 'No title'
                
                # Try to get the description from the meta tag
                description = soup.find('meta', attrs={'name': 'description'})
                if description:
                    description = description['content']
                else:
                    # Get the first <p> tag's text if no meta description is found
                    first_paragraph = soup.find('p')
                    description = first_paragraph.get_text().strip() if first_paragraph else 'No description'
                
                date_modified = datetime.fromtimestamp(os.path.getmtime(file_path)).strftime('%Y-%m-%d')
                
                index_list.append({
                    'title': title,
                    'description': description,
                    'date': date_modified,
                    'filename': filename
                })

    return index_list

def generate_html(index_list, directory):
    html_content = '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Index of HTML Files</title>
</head>
<body>
    <h1>Index of HTML Files</h1>
    <table border="1">
        <tr>
            <th>Title</th>
            <th>Description</th>
            <th>Date</th>
        </tr>'''

    for item in index_list:
        file_link = os.path.join(directory, item['filename'])
        html_content += f'''
        <tr>
            <td><a href="{file_link}">{item['title']}</a></td>
            <td>{item['description']}</td>
            <td>{item['date']}</td>
        </tr>'''

    html_content += '''
    </table>
</body>
</html>'''
    
    return html_content

if __name__ == "__main__":
    directory = input("Directory to conver: ")  # Change this to your directory
    index_list = extract_meta_data(directory)
    html_output = generate_html(index_list, directory)
    
    with open('index.html', 'w', encoding='utf-8') as output_file:
        output_file.write(html_output)

    print("Index HTML file created as 'index.html'.")
