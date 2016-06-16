FROM java:8-jre-alpine
RUN apk --update add openssl bash

ENV KEYCLOAK_VERSION 1.9.8.Final

RUN wget https://downloads.jboss.org/keycloak/${KEYCLOAK_VERSION}/keycloak-proxy-${KEYCLOAK_VERSION}.zip \
  && unzip keycloak-proxy-*.zip \
  && mv keycloak-proxy-${KEYCLOAK_VERSION} keycloak-proxy \
  && rm keycloak-proxy*.zip

EXPOSE 8080

COPY entry-point.sh /entry-point.sh
ENTRYPOINT ["/entry-point.sh"]
CMD ["/usr/bin/java", "-jar", "/keycloak-proxy/bin/launcher.jar", "/keycloak-proxy/config.json"]
