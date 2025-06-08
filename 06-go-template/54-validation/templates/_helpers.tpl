{{- define "templating-deep-dive.fullname" -}}
{{- $defaultName := printf "%s-%s" .Release.Name .Chart.Name }}
{{- .Values.customName | default $defaultName | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{- define "templating-deep-dive.selectorLabels" -}}
app: {{ .Chart.Name }}
release: {{ .Release.Name }}
managed-by: "helm"
{{- end -}}

{{/* Expects a port to be passed as the context */}}
{{- define "templating-deep-dive.validators.portRange" -}}
{{- $sanitizedPort := int . -}}
{{- if or (lt $sanitizedPort 1) (gt $sanitizedPort 65535) -}}
{{- fail (printf "Invalid port %d. Port must be between 1 and 65535" $sanitizedPort) -}}
{{- end -}}
{{- . }}
{{- end -}}