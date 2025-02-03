{{- define "full.tpl" -}}

{{ include "deployment.tpl" .}}
---
{{ include "service.clusterip.tpl" .}}
---
{{ include "volumes.tpl" .}}
---
{{ include "ingress.tpl" .}}

{{- end -}}