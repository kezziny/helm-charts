{{- define "longhorn.pvc.tpl" -}}
{{ $parts := split ":" .pvc }}
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ $parts._0 }}
spec:
  accessModes:
    - {{ default "ReadWriteOnce" .longhorn.accessMode }}
  resources:
    requests:
      storage: {{ default "1Gi" .longhorn.capacity }}
  storageClassName: longhorn
{{- end -}}