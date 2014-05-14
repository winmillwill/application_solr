#!/usr/bin/env bats

@test "cores_active" {
  for core in $(ls -d /opt/solr/shared/solr_home/*/ | cut -f 6 -d /); do
    curl -I http://localhost:8080/solr/$core/select | grep 200
  done
}
