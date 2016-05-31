FROM hypriot/rpi-ruby:2.2.2

#Install net-tools for fluent-plugin-secure-forward
RUN apt-get update \
  && apt-get install -y libcurl4-gnutls-dev net-tools build-essential \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN gem install fluentd -v "~>0.12.26" --no-ri --no-rdoc
#RUN /usr/local/bin/gem install fluent-plugin-secure-forward --no-ri --no-rdoc

RUN mkdir /etc/fluent

ADD fluent.conf /etc/fluent/
#ADD ca_cert.pem /etc/fluent/

EXPOSE 24224
#EXPOSE 24284

ENTRYPOINT ["/usr/local/bundle/bin/fluentd", "-c", "/etc/fluent/fluent.conf"]
