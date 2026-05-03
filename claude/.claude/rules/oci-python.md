---
paths:
  - "**/Tenancy Cleanup/**"
  - "**/oci_cleanup/**"
  - "**/handlers/**/*.py"
---

# OCI Python SDK Rules

## Handler Pattern
- One ResourceHandler subclass per OCI service in handlers/
- Every handler declares resource_type, dependencies, list_resources(), delete_resource()
- Use @register_handler decorator for auto-registration
- Skip resources with lifecycle_state in TERMINATED/DELETED/DELETING

## Error Handling
- Per-resource error isolation — one resource failing never stops others
- 404 on delete = success (already gone)
- 409 on delete = dependency conflict (log and continue)
- 401/403 on list = permission warning, not error
- Retry on 408, 429, 500, 502, 503, 504 + ConnectionError

## OCI Client Patterns
- Use the client factory with per-(class, region) caching
- Track failed regions — if client creation fails, skip that region for all subsequent handlers
- Object Storage namespace is cached — don't call get_namespace() repeatedly
- MysqlaasClient for MySQL configurations, DbSystemClient for MySQL instances
- API Gateway uses GatewayClient + DeploymentClient (two separate clients)