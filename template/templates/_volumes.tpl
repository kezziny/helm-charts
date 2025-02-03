{{- define "volumes.tpl" -}}
{{- range $name, $volume := .Values.volumes }}

{{ if hasKey $volume "nfs" }}
{{ include "nfs.volume.tpl" (dict "root" $ "volume" $volume) }}
---
{{ else if hasKey $volume "longhorn" }}
{{ include "longhorn.volume.tpl" (dict "root" $ "volume" $volume) }}
---
{{ else if hasKey $volume "configMap" }}
{{ include "configmap.volume.tpl" (dict "root" $ "volume" $volume) }}
---
{{ end }}

{{- end }}
{{- end -}}