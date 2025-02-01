{{- define "pv.tpl" -}}
{{- range $volume := .Values.volumes }}

{{ if hasKey $volume "nfs" }}
{{ include "nfs.pv.tpl" $volume }}
---
{{ end }}

{{- end }}
{{- end -}}