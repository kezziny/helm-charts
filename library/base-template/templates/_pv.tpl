{{- define "pv.tpl" -}}
{{- range $name, $volume := .Values.volumes }}

{{ if hasKey $volume "nfs" }}
{{ include "nfs.pv.tpl" (dict "root" $ "volume" $volume) }}
---
{{ end }}

{{- end }}
{{- end -}}