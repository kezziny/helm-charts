{{- define "nfs.pvc.tpl" -}}
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ .volume.pvc }}
  {{ if (include "service.namespace" .root )}}
  namespace: {{ include "service.namespace" .root }}
  {{ end }}
spec:
  accessModes:
    - {{ default "ReadWriteMany" .volume.nfs.accessMode }}
  resources:
    requests:
      storage: "1Mi"
  storageClassName: {{ .volume.pvc }}
{{- end -}}