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
	mkdir -p tmp/META-INF tmp/WEB-INF tmp/Upload tmp/UserManage tmp/includes
	mkdir -p tmp/WEB-INF/classes tmp/WEB-INF/lib

	# Copy HTML, JSP and CSS files
	cp WebContent/*.jsp tmp
	cp WebContent/*.html tmp
	cp -r WebContent/Upload/* tmp/Upload
	cp -r WebContent/UserManage/* tmp/UserManage
	cp -r WebContent/includes/* tmp/includes

	# Copy web.xml
	cp WebContent/WEB-INF/web.xml tmp/WEB-INF
 
	# Compile src classes
	$(JAVAC) $(JAVAFLAGS) -d tmp/WEB-INF/classes \
		-classpath $(SERVLET_API):$(SCALR):$(OJDBC):$(FILE_UPLOAD) \
		src/*.java

	# Compile database package classes
	$(JAVAC) $(JAVAFLAGS) -d tmp/WEB-INF/classes/database \
		-classpath $(SERVLET_API):$(SCALR):$(OJDBC):$(FILE_UPLOAD) \
		src/database/*.java

	# Compile the security package classes
	$(JAVAC) $(JAVAFLAGS) -d tmp/WEB-INF/classes/security \
		-classpath $(SERVLET_API):$(SCALR):$(OJDBC):$(FILE_UPLOAD) \
		src/security/*.java

	# Compile the servlets package classes
	$(JAVAC) $(JAVAFLAGS) -d tmp/WEB-INF/classes/servlets \
		-classpath $(SERVLET_API):$(SCALR):$(OJDBC):$(FILE_UPLOAD) \
		src/servlets/*.java

	# Compile the servlets.upload package classes
	$(JAVAC) $(JAVAFLAGS) -d tmp/WEB-INF/classes/security/upload \
		-classpath $(SERVLET_API):$(SCALR):$(OJDBC):$(FILE_UPLOAD) \
		src/servlets/upload/*.java

	# Compile the servlets.upload package classes
	$(JAVAC) $(JAVAFLAGS) -d tmp/WEB-INF/classes/security/usermanage \
		-classpath $(SERVLET_API):$(SCALR):$(OJDBC):$(FILE_UPLOAD) \
		src/servlets/usermanage/*.java

	# Create the Web Archive
	pushd tmp && jar -cf ../RadiologyApp.war * && popd

clean:
	rm -fR tmp *.war

.PHONY: all init doc war jar clean
