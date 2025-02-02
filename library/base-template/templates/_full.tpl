{{- define "full.tpl" -}}
{{ include "deployment.tpl" .}}
---
{{ include "service.tpl" .}}
---
{{ include "volumes.tpl" .}}
---
{{ include "ingress.tpl" .}}
{{- end -}}