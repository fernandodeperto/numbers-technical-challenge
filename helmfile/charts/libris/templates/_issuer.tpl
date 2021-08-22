{{- define "libris.issuer.tpl" -}}
apiVersion: cert-manager.io/v1
kind: Issuer
{{ template "libris.metadata" . }}
  {{- with .Values.issuer.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: {{ .Values.issuer.email }}
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: {{ include "libris.fullname" . }}
    solvers:
    - selector: {}
      http01:
        ingress:
          class: {{ .Values.issuer.ingressClass }}
{{- end -}}

{{- define "libris.issuer" -}}
{{- include "libris.merge" (append . "libris.issuer.tpl") -}}
{{- end -}}
