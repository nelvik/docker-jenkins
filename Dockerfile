From jenkins/jenkins:2.176.4
Label maintainer="nelvik"

# change to root to perform installation
USER root

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git-lfs && \
    git lfs install && \
    rm -r /var/lib/apt/lists/*

# drop back to the regular jenkins user - good practice
USER jenkins
