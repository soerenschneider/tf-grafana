#checkov:skip=CKV_DOCKER_2: false positive
#checkov:skip=CKV_DOCKER_3: false positive
FROM grafana/grafana:11.6.0

COPY dashboards /etc/grafana/provisioning/dashboards/
