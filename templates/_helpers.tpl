{{/*
Generate internal container port.
*/}}
{{- define "myproject.chat.base-config" -}}
- name: {{ .Values.model.organization }}/{{ .Values.model.name }}
  endpoints:
   - url: http://{{ include "myproject.fullname" . }}:{{ .Values.service.port | default 8080 }}
     type: "tgi"
{{- if .Values.chat.modelConfig }}{{- .Values.chat.modelConfig | toYaml | nindent 2 }}{{ end }}
{{- if .Values.chat.additionalModels }}{{ .Values.chat.additionalModels | toYaml | nindent 0 }}{{ end }}
{{- end}}
{{- define "myproject.containerPort" -}}
{{- if .Values.huggingface }}
{{- default 8080 .Values.huggingface.containerPort  }}
{{- else }}
8080
{{- end }}
{{- end}}
{{- define "common.capabilities.kubeVersion" -}}
{{- if .Values.global }}
    {{- if .Values.global.kubeVersion }}
    {{- .Values.global.kubeVersion -}}
    {{- else }}
    {{- default .Capabilities.KubeVersion.Version .Values.kubeVersion -}}
    {{- end -}}
{{- else }}
{{- default .Capabilities.KubeVersion.Version .Values.kubeVersion -}}
{{- end -}}
{{- end -}}
{{/*
Expand the name of the chart.
*/}}
{{- define "myproject.name" -}}
{{- regexReplaceAll "[\\W+_]" ( default (default .Chart.Name .Values.nameOverride) .Values.model.name | trunc 63 | trimSuffix "-" | lower ) "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "myproject.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := (regexReplaceAll "[\\W+_]" (default (default .Chart.Name .Values.nameOverride) .Values.model.name) "-") | trunc 63 | trimSuffix "-" | lower }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "myproject.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "myproject.labels" -}}
helm.sh/chart: {{ include "myproject.chart" . }}
{{ include "myproject.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "myproject.selectorLabels" -}}
app.kubernetes.io/name: {{ include "myproject.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "myproject-chat.selectorLabels" -}}
app.kubernetes.io/name: {{ include "myproject.name" . }}-chat-ui
app.kubernetes.io/instance: {{ .Release.Name }}-chat
{{- end }}
{{/*
Create the name of the service account to use
*/}}
{{- define "myproject.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "myproject.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
