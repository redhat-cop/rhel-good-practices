MAINTAINER Alessandro Rossi <alerossi@redhat.com>
FROM registry.access.redhat.com/ubi9/python-312
RUN pip3 install mkdocs mkdocs-material mkdocs-macros-plugin
ENTRYPOINT mkdocs serve
