# Reference: https://github.com/dat/stanford-ner/blob/master/Makefile on March 31, 2015

#Instructions:
# - Execute 'make war' to make a war file for Tomcat deployment.
# - Execute 'make install' to move required files into ~/catalina
# - Execute 'make clean' to clean up the working space.

JAVAC = javac
JAVAFLAGS = -O

SERVLET_API = tmp/WEB-INF/lib/servlet-api.jar
SCALR = tmp/WEB-INF/lib/imgscalr-lib-4.2.jar
OJDBC = tmp/WEB-INF/lib/ojdbc14.jar
FILE_UPLOAD = tmp/WEB-INF/lib/commons-fileupload-1.3.1.jar

SHELL = /bin/bash

all: war

init:
	mkdir -p tmp

tar: 
	tar -c README.md Makefile LICENSE WebContent src SQL_Scripts | gzip -c > project.tgz

war: init
	mkdir -p tmp/META-INF tmp/WEB-INF tmp/Upload tmp/UserManage tmp/includes
	mkdir -p tmp/WEB-INF/classes tmp/WEB-INF/lib
	mkdir -p tmp/WEB-INF/classes/database tmp/WEB-INF/classes/security tmp/WEB-INF/classes/servlets
	mkdir -p tmp/WEB-INF/classes/servlets/upload tmp/WEB-INF/classes/servlets/usermanage

	# Copy HTML, JSP and CSS files
	cp WebContent/*.jsp tmp
	cp WebContent/*.html tmp
	cp -r WebContent/Upload/* tmp/Upload
	cp -r WebContent/UserManage/* tmp/UserManage
	cp -r WebContent/includes/* tmp/includes

	# Copy web.xml
	cp WebContent/WEB-INF/web.xml tmp/WEB-INF

	# Copy libraries
	cp WebContent/WEB-INF/lib/*.jar tmp/WEB-INF/lib

	# Compile database package classes
	$(JAVAC) $(JAVAFLAGS) -d tmp/WEB-INF/classes \
		-classpath tmp/WEB-INF/classes:$(SERVLET_API):$(SCALR):$(OJDBC):$(FILE_UPLOAD) \
		src/database/*.java \
		src/security/*.java \
		src/*.java \
		src/servlets/*.java \
		src/servlets/upload/*.java \
		src/servlets/usermanage/*.java

	# Create the Web Archive
	pushd tmp && jar -cf ../RadiologyApp.war * && popd

install:
	# Put required libraries into catalina/lib
	cp ./WebContent/WEB-INF/lib/*.jar ~/catalina/lib

	# Put App in catalina/webapps
	rm -fR ~/catalina/webapps/RadiologyApp
	cp ./RadiologyApp.war ~/catalina/webapps

clean:
	rm -fR tmp *.war *.tgz
