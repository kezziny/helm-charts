{{- define "nfs.pv.tpl" -}}
{{ $parts := split ":" .pvc }}
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ $parts._0 }}
spec:
  storageClassName: {{ .pvc }}
  persistentVolumeReclaimPolicy: Retain
  capacity:
    storage: "1Mi"
  accessModes:
    - {{ default "ReadWriteMany" .nfs.accessMode }}
  nfs:
    server: {{ .nfs.server }}
    path: {{ .nfs.path }}
    readOnly: {{ default false .nfs.readOnly }}
  mountOptions:
    {{ if hasKey .nfs "options" }}
    {{- range $option := .nfs.options }}
    - {{ $option }}
    {{- end }}
    {{ else }}
    - nfsvers=3
    - tcp
    - intr
    - hard
    - noatime
    - nodiratime
    {{ end }}
{{- end -}}