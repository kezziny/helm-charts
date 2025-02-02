{{- define "service.tpl" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "service.name" $ }}
  {{ if (include "service.namespace" $ )}}
  namespace: {{ include "service.namespace" $ }}
  {{ end }}
spec:
  type: ClusterIP
  selector:
    {{- include "deployment.selectorLabels" $ | nindent 4 }}
  ports:
    {{- range $name,$portConfig := $.Values.ports }}
    - name: {{ $name }}
      protocol: TCP
      port: {{ $portConfig.port.service }}
      targetPort: {{ $name }}
    {{- end }}
{{- end -}}