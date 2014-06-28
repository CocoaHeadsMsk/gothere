#!/usr/bin/env python

import argparse
import httplib
import sys, os
import urllib
from BaseHTTPServer import BaseHTTPRequestHandler,HTTPServer
import glob
import socket

global SERVER
SERVER = "none"
ADDRESS = ""
CUR_DIR=os.path.dirname(sys.argv[0])
CONTENT_PATH='content'

class MyHandler(BaseHTTPRequestHandler):
	def send_RoadListRequest(self):
		#Open the static file requested and send it
		
		import json
		js = json.dumps({'RoadListRequest':{
			'RoadList':[
				{'RoadShot':
					{	'RoadId':'1',
						'Name':'RoadName_1',
                        'Raiting':'Stars(0-5)',
                        'Dificult':'Hard(1-5)'
                        }
                },
                {'RoadShot':
					{	'RoadId':'15',
						'Name':'Silver Trip',
                        'Raiting':'**',
                        'Dificult':'5'
                        }
                }
            ]}})
		self.path="/index.html"
		self.send_response(200)
		self.send_header('Content-type','application/json')
		self.send_header('Keep-Alive',"timeout=15, max=150")
		self.send_header('Content-Length', len(js))
		self.end_headers()
		self.wfile.write(js)
		f.close()

	def send_RoadDetailRequest(self):
		#Open the static file requested and send it
		
		import json
		js = json.dumps({"RoadDetailRequest": {
		    "RoadDetail": {
		      "RoadId": "id",
		      "Name": "RoadName",
		      "CheckPoints": [
		        {
		          "CheckPoint": {
		            "GeoPoint": {
		              "lat": 43.45,
		              "lon": 53.4
		            },
		            "url": "http://CheckPointUrl.com:8081",
		            "StoryId": "StoryId"
		          }
		        },
		        {
		          "CheckPoint": {
		            "GeoPoint": {
		              "lat": 43.55,
		              "lon": 53.4
		            },
		            "url": "http://CheckPointUrl.com:8081",
		            "StoryId": "StoryId"
		          }
		        },
		        {
		          "CheckPoint": {
		            "GeoPoint": {
		              "lat": 43.45,
		              "lon": 53.5
		            },
		            "url": "http://CheckPointUrl.com:8081",
		            "StoryId": "StoryId"
		          }
		        },
		        {
		          "CheckPoint": {
		            "GeoPoint": {
		              "lat": 43.46,
		              "lon": 53.5
		            },
		            "url": "http://CheckPointUrl.com:8081",
		            "StoryId": "StoryId"
		          }
		        },
		        {
		          "CheckPoint": {
		            "GeoPoint": {
		              "lat": 43.46,
		              "lon": 53.6
		            },
		            "url": "http://CheckPointUrl.com:8081",
		            "StoryId": "StoryId"
		          }
		        },

		      ]
		    }
		  },
		  })

		self.path="/index.html"
		self.send_response(200)
		self.send_header('Content-type','application/json')
		self.send_header('Keep-Alive',"timeout=15, max=150")
		self.send_header('Content-Length', len(js))
		self.end_headers()
		self.wfile.write(js)
		f.close()

	def send_index(self):
		self.path="/index.html"
		self.send_response(200)
		self.send_header('Content-type','text/html')
		self.end_headers()
		# Send the html message

		content_list= glob.glob("%s/%s/*"% (CUR_DIR, CONTENT_PATH) )
		print 'current', "%s/%s/*"% (CUR_DIR, CONTENT_PATH)
		print 'content list: ',content_list

		other_content = ""
		itms_services = ""

		self.wfile.write("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'>\
			<html lang='en'>\
				<head>\
					<title>Gothere entrprice distrib</title>\
				</head>\
				<body>\
				\
				<p> %s </p> \
				<h1> There is an API:</h1> \
				<br>an api </br>" % ADDRESS 
		)

		self.wfile.write("<h1>Manage api</h1>\
						<p>\
							<a href=stop>\
								Click to Stop!\
							</a>\
						</p>")

		'''self.wfile.write("<p>\
							<a href=update.html>\
								Click to update content!\
							</a>\
						</p>")
		
		self.wfile.write("<h1>Itms-service Content </h1> %s"%(itms_services))
		self.wfile.write("<h1>IPA Content</h1> %s"%(other_content)) '''
		
		self.wfile.write("\
				</body>\
			</html>\
		")
		return


	@staticmethod
	def PerformCmd(cmd):
		import subprocess
		p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
		output, err = p.communicate()
		if err <> None:
			print 'PerformCmd error: ', err
		return output, err

	def do_GET(self):
		print 'path', self.path
		if self.path=="/":
			self.path="/index.html"
		try:
			#Check the file extension required and
			#set the right mime type
			#mimetype='text/plain'

			if self.path.endswith("index.html"):
				mimetype='text/html'
				self.send_index()
				return
			if self.path.endswith("RoadListRequest"):
				self.send_RoadListRequest()
				return
			#TOOD: Add the read id
			if self.path.endswith("RoadDetailRequest"):
				self.send_RoadDetailRequest()
				return
			if self.path.endswith("stop"):
				print 'SERVER', SERVER
				SERVER.socket.close()
				print 'self.shutdown()'
				return

		except IOError:
			self.send_error(404,'File Not Found: %s' % self.path)

def run_server(port=8081):
	global SERVER 
	from BaseHTTPServer import BaseHTTPRequestHandler,HTTPServer
	try:
		#Create a web server and define the handler to manage the
		#incoming request
		server = HTTPServer(('', port), MyHandler)
		print 'Started httpserver on port ', port
	
		#Wait forever for incoming htto requests
		server.serve_forever()
		SERVER = server

	except KeyboardInterrupt:
		print '^C received, shutting down the web server'
		server.socket.close()

	#This class will handles any incoming request from
	#the browser 


if __name__ == '__main__':
	#create_plist(os.path.join(CONTENT_PATH, 'Snake-game.plist'), 'Snake-game', '<url here>', 'globusinc.Snake-game', '0.1')
	#create_plist(os.path.join(CONTENT_PATH, 'PSBBankingiPhone-1.2.12.plist'), 'PSB-Mobile', '<url here>', 'psbank.ru', '1.2.12')
	CUR_DIR=os.getcwd()
	
	print 'sys.argv: ',sys.argv
	parser = argparse.ArgumentParser(description="Server")
	parser.add_argument('-ip', 	'--Ip_addpres', 	nargs='?', default='127.0.0.1', 							help="Ip Address.", )
	parser.add_argument('-p', 	'--Port', 			nargs='?', default=8081, 									help="Port.")
	#parser.print_help()

	args = parser.parse_args()
	args.Type = 'server'

	print 'args:', args

	if args.Type == 'server':
		if socket.gethostname().find('.')>=0:
			name=socket.gethostname()
		else:
			name=socket.gethostbyaddr(socket.gethostname())[0]
		ADDRESS = "http://%s:%s" % (name, args.Port)
		print ADDRESS
		run_server(args.Port)
		