FROM ruby:2.3
COPY . /build
RUN cd /build && \
    bundle install
#ENTRYPOINT [ "/bin/bash" ]
ENTRYPOINT [ "/build/bin/wayback_machine_downloader" ]
#ENTRYPOINT [ "/usr/local/bundle/bin/wayback_machine_downloader" ]
