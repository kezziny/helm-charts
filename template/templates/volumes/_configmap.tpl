{{- define "configmap.volume.tpl" -}}
kind: ConfigMap
apiVersion: v1
metadata:
  name: {{ .volume.configMap.name }}
  {{ if (include "service.namespace" .root )}}
  namespace: {{ include "service.namespace" .root }}
  {{ end }}
data:
  {{- range $name, $@alue := .volume.configMap.data }}
  {{$name}}: |
  {{ toYaml .volume.configMap.data | nindent 4 }}
  {{- end }}
{{- end -}}