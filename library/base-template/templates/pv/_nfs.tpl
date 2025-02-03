{{- define "nfs.pv.tpl" -}}
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ .volume.pvc }}
  namespace:
  {{ if (include "service.namespace" .root )}}
  namespace: {{ include "service.namespace" .root }}
  {{ end }}
spec:
  storageClassName: {{ .volume.pvc }}
  persistentVolumeReclaimPolicy: Retain
  capacity:
    storage: "1Mi"
  accessModes:
    - {{ default "ReadWriteMany" .volume.nfs.accessMode }}
  nfs:
    server: {{ .volume.nfs.server }}
    path: {{ .volume.nfs.path }}
    readOnly: {{ default false .volume.nfs.readOnly }}
  mountOptions:
    {{ if hasKey .volume.nfs "options" }}
    {{- range $option := .volume.nfs.options }}
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