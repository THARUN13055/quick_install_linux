import requests
import base64
import subprocess

# The 
script = '''
1. jenkins_install.sh
2. docker_install.sh
'''

print(script)

file_name = str(input("Enter the needed script list here:  "))

# Set up the GitHub API endpoint
git_folder = 'https://api.github.com/repos/THARUN13055/quick_install_linux/contents/installation_script/'

# Here we get the input and add the str to b
api_endpoint = git_folder+file_name

# Send a GET request to the API endpoint
response = requests.get(api_endpoint)

# Get the content of the file from the response
content = response.json()['content']

# Decode the content from base64 and write it to a file
with open(''+a, 'wb') as f:
    f.write(base64.b64decode(content))

script = './'+a
subprocess.run(['bash',script])

