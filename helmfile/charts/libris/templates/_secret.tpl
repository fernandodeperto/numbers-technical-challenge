{{- define "libris.secret.tpl" -}}
apiVersion: v1
kind: Secret
{{ template "libris.metadata" . }}
  {{- with .Values.secret.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
stringData:
  {{- toYaml .Values.secret.data | nindent 2 }}
{{- end -}}

{{- define "libris.secret" -}}
{{- include "libris.merge" (append . "libris.secret.tpl") -}}
{{- end -}}
