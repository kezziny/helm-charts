{{- define "longhorn.pvc.tpl" -}}
{{ $parts := split ":" .pvc }}
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ $parts._0 }}
  {{ if (include "service.namespace" .)}}
  namespace: {{ include "service.namespace" . }}
  {{ end }}
spec:
  accessModes:
    - {{ default "ReadWriteOnce" .longhorn.accessMode }}
  resources:
    requests:
      storage: {{ default "1Gi" .longhorn.capacity }}
  storageClassName: longhorn
{{- end -}}