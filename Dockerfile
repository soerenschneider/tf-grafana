FROM grafana/grafana:11.6.0

COPY dashboards /etc/grafana/provisioning/dashboards/
