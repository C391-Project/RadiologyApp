# Reference: https://github.com/dat/stanford-ner/blob/master/Makefile on March 31, 2015

#Instructions:
# - Execute 'make war' to make a war file for Tomcat deployment.
# - Execute 'make clean' to clean up the working space.

JAVAC = javac
JAVAFLAGS = -O

SERVLET_API = WebContent/WEB-INF/lib/servlet-api.jar
SCALR = WebContent/WEB-INF/lib/imgscalr-lib-4.2.jar
OJDBC = WebContent/WEB-INF/lib/ojdbc14.jar
FILE_UPLOAD = WebContent/WEB-INF/lib/commons-fileupload-1.3.1.jar

SHELL = /bin/bash

all: war

init:
	mkdir -p tmp

war: init
	jar cf RadiologyApp.war WebContent 

clean:
	rm -fR tmp *.war

.PHONY: all init doc war jar clean