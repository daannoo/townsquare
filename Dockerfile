FROM node:16
RUN apt update && apt install -y\
    git
WORKDIR /app
COPY package*.json .
RUN npm install
# npm rebuild avoids having misconfigurations if npm install has been run in the folder from windows before building the docker image
RUN npm rebuild
COPY . .
CMD ["npm","run","serve"]
