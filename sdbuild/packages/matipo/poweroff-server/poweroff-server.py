#!/usr/bin/python3

"""
Very simple HTTP server in python for powering off by HTTP request
Usage::
    ./server.py [<port>]
"""
from http.server import BaseHTTPRequestHandler, HTTPServer
import logging
import os
from time import sleep

class S(BaseHTTPRequestHandler):
    def do_GET(self):
        logging.info("GET request,\nPath: %s\nHeaders:\n%s\n", str(self.path), str(self.headers))
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        if self.path=='/poweroff':
            self.wfile.write("Powering OFF".encode('utf-8'))
            sleep(1) # allow time for reponse to be sent
            os.system('poweroff')
        else:
            self.wfile.write("GET /poweroff to power off the system".encode('utf-8'))

def run(server_class=HTTPServer, handler_class=S, port=8080):
    logging.basicConfig(level=logging.INFO)
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    logging.info('Starting httpd...\n')
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
    logging.info('Stopping httpd...\n')

if __name__ == '__main__':
    from sys import argv

    if len(argv) == 2:
        run(port=int(argv[1]))
    else:
        run()
