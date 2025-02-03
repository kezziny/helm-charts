{{- define "pvc.tpl" -}}
{{- range $name, $volume := .Values.volumes }}

{{ if hasKey $volume "nfs" }}
{{ include "nfs.pvc.tpl" (dict "root" $ "volume" $volume) }}
---
{{ else }}
{{ if hasKey $volume "longhorn" }}
{{ include "longhorn.pvc.tpl" (dict "root" $ "volume" $volume) }}
---
{{ end }}
{{ end }}

{{- end }}
{{- end -}}