import requests
import base64
import subprocess
import sys

# The 
script = '''
1. jenkins_install.sh
2. docker_install.sh
'''
packages = {
	    "jenkins": "jenkins_install.sh",
	    "docker":"docker_install.sh"
	   }

arguments = sys.argv

def install(package):
	if(package in packages):
		# Set up the GitHub API endpoint
		git_folder = 'https://api.github.com/repos/THARUN13055/quick_install_linux/contents/installation_script/'
		
		# Here we get the input and add the str to b
		api_endpoint = git_folder+packages[package]
		# Send a GET request to the API endpoint
		response = requests.get(api_endpoint)
		
		# Get the content of the file from the response
		
		print(response)
		content = response.json()['content']
		
		# Decode the content from base64 and write it to a file
		with open(''+packages[package], 'wb') as f:
		    f.write(base64.b64decode(content))
		
		print("contents recieved succefully\ninstalling "+package+"...")
		
		script = './'+packages[package]
		subprocess.run(['bash',script])

if(len(arguments)<=1):
	print("python3 pacman.py install <package name>\n\npython3 pacman.py list")
	exit()
if(arguments[1]=="list"):
	for package in packages.keys():
		print(package);

if(arguments[1]=="install"):
	install(arguments[2])