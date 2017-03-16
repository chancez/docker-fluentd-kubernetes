FROM quay.io/ecnahc515/fluentd:0.14.12

MAINTAINER Chance Zibolski <chance.zibolski@gmail.com>

ENTRYPOINT ["/start-fluentd"]

ENV ELASTICSEARCH_HOST es-logging.default.svc

RUN touch /var/lib/rpm/* && yum install -y gcc-c++ && yum clean all

RUN scl enable rh-ruby23 'gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 0.26.2' && \
    scl enable rh-ruby23 'gem install --no-document fluent-plugin-elasticsearch -v 1.9.2' && \
    scl enable rh-ruby23 'gem install --no-document fluent-plugin-prometheus -v 0.2.1' && \
    scl enable rh-ruby23 'gem install --no-document fluent-plugin-systemd -v 0.1.0' && \
    scl enable rh-ruby23 'gem install --no-document fluent-plugin-record-reformer -v 0.8.3' && \
    scl enable rh-ruby23 'gem install --no-document oj -v 2.18.1' && \
    scl enable rh-ruby23 'gem cleanup fluentd'

ADD elasticsearch-template-es2x.json /etc/fluent/elasticsearch-template-es2x.json
ADD elasticsearch-template-es5x.json /etc/fluent/elasticsearch-template-es5x.json
ADD start-fluentd /start-fluentd
