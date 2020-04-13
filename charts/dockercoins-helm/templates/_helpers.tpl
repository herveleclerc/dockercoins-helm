{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "dockercoins.name" }}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this
(by the DNS naming spec).
*/}}
{{- define "dockercoins.fullname" }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Calculate webui certificate
*/}}
{{- define "dockercoins.webui-certificate" }}
{{- if (not (empty .Values.ingress.webui.certificate)) }}
{{- printf .Values.ingress.webui.certificate }}
{{- else }}
{{- printf "%s-webui-letsencrypt" (include "dockercoins.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Calculate hasher hostname
*/}}
{{- define "dockercoins.hasher-hostname" }}
{{- if (and .Values.config.hasher.hostname (not (empty .Values.config.hasher.hostname))) }}
{{- printf .Values.config.hasher.hostname }}
{{- else }}
{{- printf "%s-hasher" (include "dockercoins.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Calculate redis hostname
*/}}
{{- define "dockercoins.redis-hostname" }}
{{- if (and .Values.config.redis.hostname (not (empty .Values.config.redis.hostname))) }}
{{- printf .Values.config.redis.hostname }}
{{- else }}
{{- printf "%s-redis" (include "dockercoins.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Calculate webui hostname
*/}}
{{- define "dockercoins.webui-hostname" }}
{{- if (and .Values.config.webui.hostname (not (empty .Values.config.webui.hostname))) }}
{{- printf .Values.config.webui.hostname }}
{{- else }}
{{- if .Values.ingress.webui.enabled }}
{{- printf .Values.ingress.webui.hostname }}
{{- else }}
{{- printf "%s-webui" (include "dockercoins.fullname" .) }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Calculate webui base url
*/}}
{{- define "dockercoins.webui-base-url" }}
{{- if (and .Values.config.webui.baseUrl (not (empty .Values.config.webui.baseUrl))) }}
{{- printf .Values.config.webui.baseUrl }}
{{- else }}
{{- if .Values.ingress.webui.enabled }}
{{- $hostname := ((empty (include "dockercoins.webui-hostname" .)) | ternary .Values.ingress.webui.hostname (include "dockercoins.webui-hostname" .)) }}
{{- $path := (eq .Values.ingress.webui.path "/" | ternary "" .Values.ingress.webui.path) }}
{{- $protocol := (.Values.ingress.webui.tls | ternary "https" "http") }}
{{- printf "%s://%s%s" $protocol $hostname $path }}
{{- else }}
{{- printf "http://%s" (include "dockercoins.webui-hostname" .) }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Calculate rng hostname
*/}}
{{- define "dockercoins.rng-hostname" }}
{{- if (and .Values.config.rng.hostname (not (empty .Values.config.rng.hostname))) }}
{{- printf .Values.config.rng.hostname }}
{{- else }}
{{- printf "%s-rng" (include "dockercoins.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Calculate worker hostname
*/}}
{{- define "dockercoins.worker-hostname" }}
{{- if (and .Values.config.worker.hostname (not (empty .Values.config.worker.hostname))) }}
{{- printf .Values.config.worker.hostname }}
{{- else }}
{{- printf "%s-worker" (include "dockercoins.fullname" .) }}
{{- end }}
{{- end }}
