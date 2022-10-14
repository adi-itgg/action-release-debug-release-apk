FROM debian:10.1

LABEL "version"="1.1.0"
LABEL "com.github.actions.name"="Debug and Release APK Publisher with mapping"
LABEL "com.github.actions.description"="Build & Publish Debug and Release APK on Github"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/adi-itgg/action-release-debug-release-apk"
LABEL "maintainer"="adi-itgg"

RUN apt update \
	&& apt -y upgrade \
	&& apt install -y hub \
	&& apt install -y zip \
	&& apt autoremove \
	&& apt autoclean \
	&& apt clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
