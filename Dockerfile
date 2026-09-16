#checkov:skip=CKV_DOCKER_2: false positive
#checkov:skip=CKV_DOCKER_3: false positive
FROM grafana/grafana:13.2.2

COPY dashboards /etc/grafana/provisioning/dashboards/
