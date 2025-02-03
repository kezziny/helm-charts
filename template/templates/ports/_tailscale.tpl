{{- define "ingress.tailscale.tpl" -}}

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "service.name" .root }}
  {{ if (include "service.namespace" .root )}}
  namespace: {{ include "service.namespace" .root }}
  {{ end }}
spec:
  defaultBackend:
    service:
      name: {{ include "service.name" .root }}
      port:
        #number: 80
        name: {{ .name }}
  ingressClassName: tailscale
  tls:
    - hosts:
        - {{ .port.tailscale }}

{{- end -}}