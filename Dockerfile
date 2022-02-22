FROM adolfoale/rbase:v3
#Create by Adolfo

USER 0

# move sources.list and source.list.d
RUN mv /etc/apt/sources.list /tmp
RUN mv /etc/apt/sources.list.d/partner.list /tmp

# copy temporal sources.list
COPY sources.list /etc/apt/

# update indices
RUN apt update -qq

# install two helper packages we need
RUN apt install --no-install-recommends -y software-properties-common dirmngr wget

# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: 298A3A825C0D65DFD57CBB651716619E084DAB9
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc

# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# install R
RUN apt install --no-install-recommends -y r-base

# install more than 5000 packages CRAN
RUN echo -n | add-apt-repository ppa:c2d4u.team/c2d4u4.0+
RUN apt update

# restore souces.list and sources.list.d
RUN mv /tmp/sources.list /etc/apt/
RUN mv /tmp/partner.list /etc/apt/sources.list.d/
