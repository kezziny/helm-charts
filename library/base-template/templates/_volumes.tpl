{{- define "volumes.tpl" -}}
{{ include "pv.tpl" $ }}
{{ include "pvc.tpl" $ }}
{{- end -}}