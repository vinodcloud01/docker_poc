FROM grafana/grafana:11.4.0

# Copy default provisioning files into the image
COPY grafana/provisioning /etc/grafana/provisioning

# Copy the custom entrypoint script into the image
COPY grafana/custom-entrypoint.sh /custom-entrypoint.sh

# Use the custom script as the entrypoint
ENTRYPOINT ["/custom-entrypoint.sh"]
