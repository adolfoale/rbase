FROM adolfoale/rbase:v1

# install more than 5000 packages CRAN
RUN apt update
RUN apt install gpg-agent
RUN echo -n | add-apt-repository ppa:c2d4u.team/c2d4u4.0+
RUN sed -i 's/impish/focal/g' /etc/apt/sources.list.d/c2d4u_team-ubuntu-c2d4u4_0_-impish.list
RUN apt update
RUN apt install --no-install-recommends -y r-cran-rstan
