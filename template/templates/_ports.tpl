{{- define "ingress.tpl" -}}
{{- range $name,$port := $.Values.ports }}

{{ if hasKey $port "tailscale" }}
{{ include "ingress.tailscale.tpl" (dict "root" $ "name" $name "port" $port) }}
{{ end }}

{{- end }}
{{- end -}}