{{/*
Expand the name of the chart.
*/}}
{{- define "libris.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "libris.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
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
{{- define "libris.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "libris.labels" -}}
helm.sh/chart: {{ include "libris.chart" . }}
{{ include "libris.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "libris.selectorLabels" -}}
app.kubernetes.io/name: {{ include "libris.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "libris.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "libris.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Set Kubernetes version
*/}}
{{- define "libris.kubeVersion" -}}
{{- default .Capabilities.KubeVersion.Version .Values.kubeVersion }}
{{- end }}

{{- /*
libris.merge will merge two YAML templates and output the result.
This takes an array of three values:
- the top context
- the template name of the overrides (destination)
- the template name of the base (source)
*/}}
{{- define "libris.merge" -}}
{{- $top := first . -}}
{{- $overrides := fromYaml (include (index . 1) $top) | default (dict ) -}}
{{- $tpl := fromYaml (include (index . 2) $top) | default (dict ) -}}
{{- toYaml (merge $overrides $tpl) -}}
{{- end -}}


{{/* Merge the local chart values and the libris chart defaults */}}
{{- define "libris.mergeValues" -}}
{{- if .Values.libris -}}
{{- $defaultValues := deepCopy .Values.libris -}}
{{- $userValues := deepCopy (omit .Values "libris") -}}
{{- $mergedValues := mustMergeOverwrite $defaultValues $userValues -}}
{{- $_ := set . "Values" (deepCopy $mergedValues) -}}
{{- end -}}
{{- end -}}

{{- define "libris.metadata" -}}
metadata:
  name: {{ include "libris.fullname" . }}
  labels:
    {{- include "libris.labels" . | nindent 4 }}
{{- end -}}
