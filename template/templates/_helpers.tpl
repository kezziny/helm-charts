{{- define "service.namespace" -}}
{{- .Values.namespace | default "" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "service.name" -}}
{{- default .Chart.Name .Values.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "deployment.selectorLabels" -}}
app.kubernetes.io/name: {{ include "service.name" . }}
app.kubernetes.io/instance: {{ $.Release.Name }}
{{- end }}

{{- define "deployment.labels" -}}
helm.sh/chart: {{ include "service.chart" . }}
{{ include "deployment.selectorLabels" . }}
{{- if $.Chart.AppVersion }}
app.kubernetes.io/version: {{ $.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ $.Release.Service }}
{{- end }}