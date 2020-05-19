FROM cirrusci/flutter:stable
COPY src /usr/src/app/epicovid
RUN sudo chown -R cirrus:cirrus /usr/src/app/epicovid
WORKDIR /usr/src/app/epicovid
RUN ["flutter", "--version"]
RUN ["flutter", "pub", "get"]
RUN ["flutter", "clean"]
RUN ["flutter", "packages", "get"]
RUN ["flutter", "packages", "upgrade"]
RUN ["flutter", "build", "apk"]
CMD ["cp", "-r", "build", "/shared-volume"]
