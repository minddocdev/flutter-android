# ------------------------------------------------------
#                       Dockerfile
# ------------------------------------------------------
# image:    flutter
# name:     minddocdev/flutter-android
# repo:     https://github.com/minddocdev/flutter-android
# Requires: ubuntu:18.04
# authors:  development@minddoc.com
# ------------------------------------------------------
FROM ubuntu:18.04

LABEL maintainer="development@minddoc.com"

ARG FLUTTER_VERSION=v1.7.8+hotfix.3
ENV FLUTTER_PATH=/flutter/bin
ENV VERSION_SDK_TOOLS "4333796"
ENV ANDROID_HOME "/sdk"
ENV PATH "$PATH:${ANDROID_HOME}/tools"
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && \
  apt-get install -qqy --no-install-recommends \
  bzip2 \
  curl \
  git-core \
  html2text \
  openjdk-8-jdk \
  lcov \
  libc6-i386 \
  libglu1 \
  lib32stdc++6 \
  lib32gcc1 \
  lib32ncurses5 \
  lib32z1 \
  unzip \
  xz-utils \
  locales \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN rm -f /etc/ssl/certs/java/cacerts; \
  /var/lib/dpkg/info/ca-certificates-java.postinst configure

WORKDIR /

### ANDROID

RUN curl -s https://dl.google.com/android/repository/sdk-tools-linux-${VERSION_SDK_TOOLS}.zip > /sdk.zip && \
  unzip /sdk.zip -d /sdk && \
  rm -v /sdk.zip

RUN mkdir -p $ANDROID_HOME/licenses/ \
  && echo "8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e\n24333f8a63b6825ea9c5514f83c2829b004d1fee" > $ANDROID_HOME/licenses/android-sdk-license \
  && echo "84831b9409646a918e30573bab4c9c91346d8abd\n504667f4c0de7af1a06de9f4b1727b84351f2910" > $ANDROID_HOME/licenses/android-sdk-preview-license

# ADD packages.txt /sdk
RUN mkdir -p /root/.android && \
  touch /root/.android/repositories.cfg && \
  ${ANDROID_HOME}/tools/bin/sdkmanager --update

# RUN while read -r package; do PACKAGES="${PACKAGES}${package} "; done < /sdk/packages.txt && \
#   ${ANDROID_HOME}/tools/bin/sdkmanager ${PACKAGES}

RUN yes | ${ANDROID_HOME}/tools/bin/sdkmanager "add-ons;addon-google_apis-google-24" \
  "add-ons;addon-google_apis-google-24" \
  "build-tools;29.0.0" \
  "extras;android;m2repository" \
  "extras;google;google_play_services" \
  "extras;google;m2repository" \
  "platform-tools" \
  "platforms;android-29" \
  "extras;google;instantapps" \
  "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" \
  "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2"

RUN yes | ${ANDROID_HOME}/tools/bin/sdkmanager --licenses

### FLUTTER

RUN git clone --branch ${FLUTTER_VERSION} --depth=1 https://github.com/flutter/flutter.git && \
  ${FLUTTER_PATH}/flutter doctor && \
  apt-get remove -y curl unzip && \
  apt autoremove -y && \
  rm -rf /var/lib/apt/lists/*

ENV PATH $PATH:${FLUTTER_PATH}/cache/dart-sdk/bin:${FLUTTER_PATH}

RUN yes | flutter doctor --android-licenses