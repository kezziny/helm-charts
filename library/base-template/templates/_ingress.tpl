{{- define "ingress.tpl" -}}
{{- range $name,$portConfig := $.Values.ports }}
{{ if hasKey $portConfig "tailscale" }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "service.name" $ }}
  {{ if (include "service.namespace" $)}}
  namespace: {{ include "service.namespace" $ }}
  {{ end }}
spec:
  defaultBackend:
    service:
      name: {{ include "service.name" $ }}
      port:
        #number: 80
        name: {{ $name }}
  ingressClassName: tailscale
  tls:
    - hosts:
        - {{ $portConfig.tailscale }}
{{ end }}
{{- end }}
{{- end -}}