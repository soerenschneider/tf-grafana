#checkov:skip=CKV_DOCKER_2: false positive
#checkov:skip=CKV_DOCKER_3: false positive
FROM grafana/grafana:12.4.3

COPY dashboards /etc/grafana/provisioning/dashboards/
