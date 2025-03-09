FROM i386/debian:8-slim

# Force Debian 8 installation!
RUN echo "deb http://archive.debian.org/debian jessie main contrib non-free" > /etc/apt/sources.list

# 1) Install dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget libc6 libstdc++6 --force-yes

# 2) Create user
RUN groupadd -r hlds
RUN useradd --no-log-init --system --create-home --home-dir /server --gid hlds  hlds
USER hlds

# Clean up unnecessary files to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Create user
RUN groupadd -r hlds && useradd --no-log-init --system --create-home --home-dir /server --gid hlds hlds
USER hlds

# Download and extract HLDS
RUN wget -q -O -  https://archive.org/download/hlds_l_3111_full/hlds_l_3111_full.bin | \
  tail -c+8338 | head -c121907818 | \
  tar -xzf - -C /server

COPY install/hlds_l_3111e_update.tar.gz /server 
RUN tar -xzf /server/hlds_l_3111e_update.tar.gz -C /server
RUN rm /server/hlds_l_3111e_update.tar.gz

# Download and install Counter-Strike 1.5
RUN curl -L -o /tmp/cs_15_full.tar.gz https://archive.org/download/hlds_l_3111_full_202503/cs_15_full.tar.gz && \
    tar -xzf /tmp/cs_15_full.tar.gz -C /server/hlds_l/ && \
    rm /tmp/cs_15_full.tar.gz

# Install Metamod (Ensure directory exists first)
RUN mkdir -p /server/hlds_l/cstrike/addons/metamod/ && \
    curl -L -o /tmp/all_in_one_3.2a.zip https://archive.org/download/hlds_l_3111_full_202503/all_in_one_3.2a.zip && \
    unzip -o /tmp/all_in_one_3.2a.zip -d /server/hlds_l/ && \
    rm /tmp/all_in_one_3.2a.zip

# Install Podbot (Ensure correct extraction path)
RUN mkdir -p /server/hlds_l/cstrike/addons/podbot/ && \
    curl -L -o /tmp/podbot_full_V3B22.zip https://archive.org/download/hlds_l_3111_full_202503/podbot_full_V3B22.zip && \
    unzip -o /tmp/podbot_full_V3B22.zip -d /server/hlds_l/cstrike/addons/ && \
    rm /tmp/podbot_full_V3B22.zip

WORKDIR /server/hlds_l/

#Install WON2Fixes and modified HLDS_RUN
USER root

COPY config ./
RUN chmod +x hlds_run

# Modify hlds_run to include LD_PRELOAD
RUN sed -i '/^export /a export LD_PRELOAD="nowon.so hlshield.so"' /server/hlds_l/hlds_run

# Then, remove mod folders
RUN rm -rf ./tfc
RUN rm -rf ./dmc
RUN rm -rf ./ricochet
RUN rm -rf ./cstrike

USER hlds

ENV TERM xterm

ENTRYPOINT ["./hlds_run"]

CMD ["-game valve", "+map crossfire", "+maxplayers 16"]
