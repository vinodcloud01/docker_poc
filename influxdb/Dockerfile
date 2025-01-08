FROM influxdb:2.7

# Copy the custom entrypoint script into the image
COPY influxdb/custom-entrypoint.sh /custom-entrypoint.sh

# Set the script as executable
RUN chmod +x /custom-entrypoint.sh

# Use the custom script as the entrypoint
ENTRYPOINT ["/custom-entrypoint.sh"]
