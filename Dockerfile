# cedric steve dockerfile

FROM ubuntu:14.04
MAINTAINER pericles_mayer@hotmail.com.tw
RUN apt-get -y update

#python
RUN apt-get -y install python-dev
RUN apt-get -y install python-pip
RUN pip install numpy

# dpkg
RUN apt-get install -y  dpkg-dev

# git
RUN apt-get install -y git

#suitesparse
RUN apt-get -y -f install software-properties-common python-software-properties
RUN add-apt-repository ppa:bzindovic/suitesparse-bugfix-1319687
RUN apt-get -y update
RUN apt-get -y install libsuitesparse-dev

#atlast form source
RUN cd opt/ && apt-get source atlas && apt-get -y build-dep atlas && apt-get -y install devscripts

#inter atlast directory
RUN cd opt/atlas-3.10.1/ && fakeroot debian/rules custom
RUN cd opt/ && dpkg -i libatlas3-base_*.deb

#install cvxopt
RUN cd opt/ && git init && git clone  https://github.com/yclin1054634/cvxopt.git 
RUN cd opt/cvxopt/ && python setup.py install 

# default process
CMD /bin/bash
