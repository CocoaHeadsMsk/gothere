#!/usr/bin python

import argparse
import httplib
import sys, os
import urllib
from BaseHTTPServer import BaseHTTPRequestHandler,HTTPServer
import glob
import socket

import sys 
reload(sys)
sys.setdefaultencoding('utf-8')

''' 
	how to run it from terminal:
	#!/usr/bin python  #for derbian
	mkdir GothereServerRuntime
	cd GothereServerRuntime
	curl https://raw.githubusercontent.com/CocoaHeadsMsk/gothere/master/Server/GoThereServer.py > GoThereServer.py
	chmod g+w GoThereServer.py 
	python GoThereServer.py
'''

SERVER = None
ADDRESS = ""
CUR_DIR=os.path.dirname(sys.argv[0])
CONTENT_PATH='content'

class MyHandler(BaseHTTPRequestHandler):
	def send_RoadListRequest(self):
		#Open the static file requested and send it
		
		import json
		js = json.dumps({
		    "RoadListRequest": {
		        "RoadList": [
		            { "RoadShot": {
		                "Dificult": 1,
		                "FinishedByUser": True,
		                "Raiting": "**",
		                "Name": "Moscow casual",
		                "RoadId": "1",
		                "Points" : 11
		            } },
		            { "RoadShot": {
		                "Dificult": 2,
		                "FinishedByUser": False,
		                "Raiting": "***",
		                "Name": "Moscow urban",
		                "RoadId": "2",
		                "Points" : 0
		            } },
		        { "RoadShot": {
		            "Dificult": 3,
		            "FinishedByUser": False,
		            "Raiting": "*****",
		            "Name": "Thrash adventures",
		            "RoadId": "3",
		            "Points" : 0
		        }
		        }
		        ]
		    }
			})
		self.path="/index.html"
		self.send_response(200)
		self.send_header('Content-type','application/json')
		self.send_header('Keep-Alive',"timeout=15, max=150")
		self.send_header('Content-Length', len(js))
		self.end_headers()
		self.wfile.write(js)


	def send_RoadDetailRequest(self, idr):
		#Open the static file requested and send it
		
		import json
		data = [
				json.dumps({"RoadDetailRequest": {
			    "RoadDetail": {
			        "RoadId": "0",
			        "Name": "Mail.ru",
			        "CheckPoints": [
			            {
			            "CheckPoint": {
			                "GeoPoint": {
			                    "lat": 55.797302,
			                    "lon": 37.537745
			                },
			                "url": "https://pp.vk.me/c618822/v618822943/c8ce/Id-OLHRKEv4.jpg",
			                "pointTitle" : "Offce Mail.ru",
			                "StoryId": "0"
			            }
			        },
			        {
			            "CheckPoint": {
			                "GeoPoint": {
			                    "lat": 55.799749, 
			                    "lon": 37.532402
			                },
			                "url": "https://pp.vk.me/c618822/v618822943/c8d7/5DL8L64xTRo.jpg",
			                "pointTitle" : "Metro Airport",
			                "StoryId": "1"
			            }
			        },
			        {
			            "CheckPoint": {
			                "GeoPoint": {
			                    "lat": 55.802770, 
			                    "lon": 37.525203
			                },
			                "url": "https://pp.vk.me/c618822/v618822943/c8dd/vwsUaAkpyi0.jpg",
			                "pointTitle" : "Cherchel pub",
			                "StoryId": "2"
			            }
			        },
			        {
			            "CheckPoint": {
			                "GeoPoint": {
			                    "lat": 55.803923, 
			                    "lon": 37.514083
			                },
			                "url": "https://pp.vk.me/c618822/v618822943/c8e6/A3yf_gDY94Q.jpg",
			                "pointTitle" : "All Saints Church",
			                "StoryId": "3"
			            }
			        },
			        {
			            "CheckPoint": {
			                "GeoPoint": {
			                    "lat": 55.811072, 
			                    "lon": 37.502378
			                },
			                "url": "https://pp.vk.me/c618822/v618822943/c8ef/x0bQmanN8kk.jpg",
			                "pointTitle" : "Moscow Aviation Institute",
			                "StoryId": "4"
			            }
			        }

			        ]
			    }
			}
			}),
			json.dumps({"RoadDetailRequest": {
			    "RoadDetail": {
			        "RoadId": "1",
			        "Name": "Mail.ru",
			        "CheckPoints": [
			            {
			            "CheckPoint": {
			                "GeoPoint": {
			                    "lat": 43.45,
			                    "lon": 53.4
			                },
			                "url": "http://media-cdn.tripadvisor.com/media/photo-s/03/9b/2f/e2/moscow.jpg",
			                "pointTitle" : "Tree",
			                "StoryId": "5"
			            }
			        },
			        {
			            "CheckPoint": {
			                "GeoPoint": {
			                    "lat": 43.55,
			                    "lon": 53.4
			                },
			                "url": "http://media-cdn.tripadvisor.com/media/photo-s/03/9b/2f/e2/moscow.jpg",
			                "pointTitle" : "Wall",
			                "StoryId": "6"
			            }
			        },
			        {
			            "CheckPoint": {
			                "GeoPoint": {
			                    "lat": 43.45,
			                    "lon": 53.5
			                },
			                "url": "http://media-cdn.tripadvisor.com/media/photo-s/03/9b/2f/e2/moscow.jpg",
			                "pointTitle" : "Way",
			                "StoryId": "2"
			            }
			        },
			        {
			            "CheckPoint": {
			                "GeoPoint": {
			                    "lat": 43.46,
			                    "lon": 53.5
			                },
			                "url": "http://media-cdn.tripadvisor.com/media/photo-s/03/9b/2f/e2/moscow.jpg",
			                "pointTitle" : "Sky",
			                "StoryId": "3"
			            }
			        },
			        {
			            "CheckPoint": {
			                "GeoPoint": {
			                    "lat": 43.46,
			                    "lon": 53.6
			                },
			                "url": "http://media-cdn.tripadvisor.com/media/photo-s/03/9b/2f/e2/moscow.jpg",
			                "pointTitle" : "Place",
			                "StoryId": "4"
			            }
			        }

			        ]
			    }
			}
			})
		]

		self.path="/index.html"
		self.send_response(200)
		self.send_header('Content-type','application/json')
		self.send_header('Keep-Alive',"timeout=15, max=150")
		
		self.send_header('Content-Length', len(data[idr]))
		self.end_headers()
		self.wfile.write(data[idr])

	def send_StoryRequest(self, ids):
		#Open the static file requested and send it
		import json
		data = [
			json.dumps({"StoryRequest": {
				"Story": {
						"StoryId": "0",
						"Title": "Offce Mail.ru",
						"Description":"There was nothing so very remarkable in that; nor did Alice think it so very much out of the way to hear the Rabbit say to itself, `Oh dear! Oh dear! I shall be late!' (when she thought it over afterwards, it occurred to her that she ought to have wondered at this, but at the time it all seemed quite natural); but when the Rabbit actually took a watch out of its waistcoat- pocket, and looked at it, and then hurried on, Alice started to her feet, for it flashed across her mind that she had never before seen a rabbit with either a waistcoat-pocket, or a watch to take out of it, and burning with curiosity, she ran across the field after it, and fortunately was just in time to see it pop down a large rabbit-hole under the hedge. ",
						"PhotoDescriptionUrl": "https://pp.vk.me/c618822/v618822943/c8ce/Id-OLHRKEv4.jpg"
						}
				}
			}),
			json.dumps({"StoryRequest": {
				"Story": {
						"StoryId": "1",
						"Title": "Metro Airport",
						"Description":"The rabbit-hole went straight on like a tunnel for some way, and then dipped suddenly down, so suddenly that Alice had not a moment to think about stopping herself before she found herself falling down a very deep well. ",
						"PhotoDescriptionUrl": "https://pp.vk.me/c618822/v618822943/c8d7/5DL8L64xTRo.jpg"
						}
				}
			}),
			json.dumps({"StoryRequest": {
				"Story": {
						"StoryId": "2",
						"Title": "Cherchel pub",
						"Description": " Either the well was very deep, or she fell very slowly, for she had plenty of time as she went down to look about her and to wonder what was going to happen next. First, she tried to look down and make out what she was coming to, but it was too dark to see anything; then she looked at the sides of the well, and noticed that they were filled with cupboards and book-shelves; here and there she saw maps and pictures hung upon pegs. She took down a jar from one of the shelves as she passed; it was labelled `ORANGE MARMALADE', but to her great disappointment it was empty: she did not like to drop the jar for fear of killing somebody, so managed to put it into one of the cupboards as she fell past it. ",
						"PhotoDescriptionUrl": "https://pp.vk.me/c618822/v618822943/c8dd/vwsUaAkpyi0.jpg"
						}
				}
			}),
			json.dumps({"StoryRequest": {
				"Story": {
						"StoryId": "3",
						"Title": "All Saints Church",
						"Description": "What a curious feeling!' said Alice; 'I must be shutting up like a telescope.",
						"PhotoDescriptionUrl": "https://pp.vk.me/c618822/v618822943/c8e6/A3yf_gDY94Q.jpg"
						}
				}
			}),
			json.dumps({"StoryRequest": {
				"Story": {
						"StoryId": "4",
						"Title": "Moscow Aviation Institute",
						"Description": "'Well!' thought Alice to herself, 'after such a fall as this, I shall think nothing of tumbling down stairs! How brave they'll all think me at home! Why, I wouldn't say anything about it, even if I fell off the top of the house!' (Which was very likely true.) ",
						"PhotoDescriptionUrl": "https://pp.vk.me/c618822/v618822943/c8ef/x0bQmanN8kk.jpg"
						}
				}
			}),
			json.dumps({"StoryRequest": {
				"Story": {
						"StoryId": "5",
						"Title": "Ad",
						"Description": "There Could be your advertizing!",
						"PhotoDescriptionUrl": "http://media-cdn.tripadvisor.com/media/photo-s/03/9b/2f/e2/moscow.jpg"
						}
				}
			}),
			json.dumps({"StoryRequest": {
				"Story": {
						"StoryId": "6",
						"Title": "6",
						"Description": "description",
						"PhotoDescriptionUrl": "http://media-cdn.tripadvisor.com/media/photo-s/03/9b/2f/e2/moscow.jpg"
						}
				}
			})
		]


		self.path="/index.html"
		self.send_response(200)
		self.send_header('Content-type','application/json')
		self.send_header('Keep-Alive',"timeout=15, max=150")
		self.send_header('Content-Length', len(data[ids]))
		self.end_headers()
		self.wfile.write(data[ids])

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
				<p> Server address <br> %s </p> " % ADDRESS 
		)

		self.wfile.write("<h1>Server api</h1> \
							<p>\
							<text> RoadListRequest\n RoadDetailRequest\n StoryRequest\
							</text>\
							</p><p>\
							<a href=RoadListRequest>\
								Click to get RoadListRequest\
							</a>\
							<text> <br> RoadDetailRequest <br> </text>\
								<form method=\"get\" action=\"RoadDetailRequest\">\
								<input type=\"text\" name=\"Id\" value=\"0\"/>\
								<input type=\"submit\" name=\"\" />\
								</form>\
								<text><br> StoryRequest <br> </text>\
								<form method=\"get\" action=\"StoryRequest\">\
								<input type=\"text\" name=\"Id\" value=\"0\"/>\
								<input type=\"submit\" name=\"\" />\
								</form>\
							</p>")
		self.wfile.write("<h1>Manage commands</h1>\
						<p>\
							<a href=stop>\
								Click to Stop!\
							</a>\
						</p>")
		
		'''self.wfile.write("<h1>Itms-service Content </h1> %s"%(itms_services))
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
			if self.path.find("RoadDetailRequest?")!=-1:
				from urlparse import urlparse, parse_qs
				params = parse_qs(urlparse(self.path).query)
				print params
				id = params['Id'][0]
				self.send_RoadDetailRequest(int (id))
				return
			if self.path.find("StoryRequest?")!=-1:
				from urlparse import urlparse, parse_qs
				params = parse_qs(urlparse(self.path).query)
				print params
				id = params['Id'][0]
				self.send_StoryRequest(int(id))
				return
			if self.path.endswith("stop"):
				print 'SERVER', SERVER
				SERVER.socket.close()
				print 'self.shutdown()'
				return

		except Exception, e :
			self.send_error(404,'internal error: %s\n %s' % (self.path, e) )

def run_server(port=8081):
	global SERVER 
	from BaseHTTPServer import BaseHTTPRequestHandler,HTTPServer
	try:
		#Create a web server and define the handler to manage the
		#incoming request
		server = HTTPServer(('', port), MyHandler)
		print 'Started httpserver on port ', port
		SERVER = server
		#Wait forever for incoming htto requests
		server.serve_forever()


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
	parser.add_argument('-p', 	'--Port', type=int,			nargs='?', default=8081, 									help="Port.")
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
		