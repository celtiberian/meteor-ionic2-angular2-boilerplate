# inspired by: 
#	- https://github.com/Treecom/alpine-meteor/blob/master/Dockerfile

FROM mhart/alpine-node:4.8.2

ENV NODE_VERSION=4.8.2 GYP_DEFINES="linux_use_gold_flags=0" INSTALL_PACKAGES="python make gcc g++ git libuv bash curl tar bzip2" UNINSTALL_PACKAGES="python make g++ gcc git curl tar bzip2"

# Create user meteor who will run all entrypoint instructions
RUN adduser meteor -h /home/meteor -s /bin/bash -D
WORKDIR /home/meteor

# copy the production bundle (must be generated outside)
COPY ./.build/bundle /home/meteor/build/bundle

# copy docker .sh files
COPY ./docker/*.sh /home/meteor/docker/

# Add known_hosts file
COPY docker/known_hosts ../.ssh/known_hosts

# Install needed packages, then uninstall in the same RUN step (otherwise the uninstalled space won't we reclaimed in the final image)
RUN apk --update --no-cache add ${INSTALL_PACKAGES}  && \
	mkdir -p /root  && \
	ln -s /usr/bin/node /usr/bin/nodejs  && \
	npm install -g npm@3  && \
	npm install -g node-gyp  && \
	node-gyp install ${NODE_VERSION}  && \
	echo "Installing application-side NPM dependencies..."  && \
	cd /home/meteor/build/bundle/programs/server  && \
	npm install --production && \
	npm uninstall -g node-gyp  && \
	apk del ${UNINSTALL_PACKAGES}

# make sure all files are owned by user meteor and only have read/write permissions (except shell scrips that need to be executable)
RUN	cd /home/meteor && \
	chown -R meteor:meteor .  && \
	chmod -R 666 .  && \
	find . -type d -exec chmod 744 {} \;  && \
	chmod 766 docker/*.sh

EXPOSE 3000

# Execute entrypoint as user meteor
USER meteor
ENTRYPOINT ["/home/meteor/docker/app_entrypoint.sh"]
CMD []

