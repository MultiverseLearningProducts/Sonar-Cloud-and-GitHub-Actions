# syntax=docker/dockerfile:1

# specify my baseImage and (optionally) the version and alias
FROM node:14.17.1 as base
# specify the path of the working directory
WORKDIR /app
# copy just the package*.json to specify dependencies
COPY package.json package.json
COPY package-lock.json package-lock.json

# create a buildstage for test
FROM base as test
# clean install dependencies
RUN npm ci
# copy all files to test buildstage
COPY . .
# the command to test our app
CMD ["npm","run","test"]

# create a buildstage for prod
FROM base as prod
# clean install production dependencies - ignoring devDependencies
RUN npm ci --production
# copy all files to prod buildstage
COPY . .
#expose the port in the docker container
EXPOSE 3000
# the command to run our app
CMD ["npm", "run", "start"]