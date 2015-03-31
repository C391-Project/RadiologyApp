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
	mkdir -p tmp/META-INF tmp/WEB-INF
	mkdir -p tmp/WEB-INF/classes tmp/WEB-INF/lib tmp/WEB-INF/resources
 
	$(JAVAC) $(JAVAFLAGS) -d tmp/WEB-INF/classes \
		-classpath $(SERVLET_API):$(SCALR):$(OJDBC):$(FILE_UPLOAD) \
		src/*.java
		src/*/*.java
		src/*/*/*.java
	pushd tmp && jar -cfm ../RadiologyApp.war ../WebContent/META-INF/MANIFEST.MF * && popd

clean:
	rm -fR tmp *.war

.PHONY: all init doc war jar clean