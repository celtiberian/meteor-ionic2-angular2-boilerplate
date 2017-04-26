FROM meteor:base

# copy all source code (again, it may have changed) to the image (non-sources ignored in .dockerignore, in project root).
COPY . .

# make sure all files are owned by user meteor and only have read/write permissions (except shell scrips that need to be executable)
RUN	chown -R meteor:meteor .  && \
	chmod -R 666 .  && \
	find . -type d -exec chmod 744 {} \;  && \
	chmod 766 docker/*.sh

# Allow node to listen to port 80 even when run by non-root user meteor
RUN setcap 'cap_net_bind_service=+ep' /usr/bin/nodejs

USER meteor
RUN	echo "Installing application-side NPM dependencies..."  && \
	npm install --production  && \
	echo "Building the bundle...(this may take a while)"  && \
	mkdir -p ../build  && \
	meteor build --directory ../build  && \
	cd /home/meteor/build/bundle/programs/server  && \
	npm install --production
	
EXPOSE 3000

# Execute entrypoint as user meteor
ENTRYPOINT ["/home/meteor/app/docker/app_entrypoint.sh"]
CMD []
