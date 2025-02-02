{{- define "pvc.tpl" -}}
{{- range $name, $volume := .Values.volumes }}

{{ if hasKey $volume "nfs" }}
{{ include "nfs.pvc.tpl" $volume }}
---
{{ else }}
{{ if hasKey $volume "longhorn" }}
{{ include "longhorn.pvc.tpl" $volume }}
---
{{ end }}
{{ end }}

{{- end }}
{{- end -}}