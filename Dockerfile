FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update && \
    apt-get install -y tmate tzdata expect python3 && \
    ln -fs /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

# Set working directory
WORKDIR /app

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose port for web access (Render needs this)
EXPOSE 8000

# Run start script
CMD ["/start.sh"]
