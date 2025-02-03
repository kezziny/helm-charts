{{- define "longhorn.pvc.tpl" -}}
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ .volume.pvc }}
  {{ if (include "service.namespace" .root )}}
  namespace: {{ include "service.namespace" .root }}
  {{ end }}
spec:
  accessModes:
    - {{ default "ReadWriteOnce" .volume.longhorn.accessMode }}
  resources:
    requests:
      storage: {{ default "1Gi" .volume.longhorn.capacity }}
  storageClassName: longhorn
{{- end -}}