{{- define "nfs.pvc.tpl" -}}
{{ $parts := split ":" .pvc }}
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ $parts._0 }}
spec:
  accessModes:
    - {{ default "ReadWriteMany" .nfs.accessMode }}
  resources:
    requests:
      storage: "1Mi"
  storageClassName: {{ $parts._0 }}
{{- end -}}