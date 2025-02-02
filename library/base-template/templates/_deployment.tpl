{{- define "deployment.tpl" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "service.name" . }}
  {{ if (include "service.namespace" .)}}
  namespace: {{ include "service.namespace" . }}
  {{ end }}
  labels:
    {{- include "deployment.labels" . | nindent 4 }}
spec:
  {{ if and (hasKey $.Values "ha") (hasKey $.Values.ha "replicas") }}
  replicas: {{ $.Values.replicas | default 1 }}
  {{ end }}
  selector:
    matchLabels:
      {{- include "deployment.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels:
        {{- include "deployment.selectorLabels" . | nindent 8 }}
    spec:
      volumes:
        {{- range $name, $volume := $.Values.volumes }}
        - name: {{ $name }}
          persistentVolumeClaim:
            claimName: {{ $volume.pvc }}
        {{- end }}
      containers:
        - name: {{ include "service.name" . }}
          image: {{ $.Values.image }}
          imagePullPolicy: {{ $.Values.imagePullPolicy | default "IfNotPresent" }}
          volumeMounts:
            {{- range $name,$volume := .Values.volumes }}
            - name: {{ $name }}
              mountPath: {{ $volume.path }}
            {{- end }}
          ports:
            {{- range $name,$portConfig := $.Values.ports }}
            - name: {{ $name }}
              containerPort: {{ $portConfig.port.container }}
              protocol: {{ $portConfig.protocol | default "TCP" }}
            {{- end }}
          env:
            {{- range $k,$v := $.Values.env }}
            - name: {{ $k }}
              value: {{ $v | quote }}
            {{- end }}
          {{ if and (hasKey $.Values "ha") (hasKey $.Values.ha "probe") }}
          startupProbe:
            httpGet:
              path: {{ $.Values.ha.probe.path }}
              port: {{ $.Values.ha.probe.port }}
            failureThreshold: {{ $.Values.ha.probe.failureThreshold | default 10 }}
            periodSeconds: {{ $.Values.ha.probe.periodSeconds | default 30 }}
          livenessProbe:
            httpGet:
              path: {{ $.Values.ha.probe.path }}
              port: {{ $.Values.ha.probe.port }}
            failureThreshold: {{ $.Values.ha.probe.failureThreshold | default 10 }}
            periodSeconds: {{ $.Values.ha.probe.periodSeconds | default 30 }}
          {{ else }}
          {{ if and (hasKey $.Values "ha") (hasKey $.Values.ha "startupProbe") }}
          startupProbe:
            {{ toYaml $.Values.ha.startupProbe | nindent 12 }}
          {{ end }}
          {{ if and (hasKey $.Values "ha") (hasKey $.Values.ha "livenessProbe") }}
          livenessProbe:
            {{ toYaml $.Values.ha.livenessProbe | nindent 12 }}
          {{ end }}
          {{ end }}
{{- end -}}