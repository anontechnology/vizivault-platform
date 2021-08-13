{{/* vim: set filetype=mustache: */}}

{{/*
Create a random alphanumeric password
*/}}
{{- define "vizivault-platform.randomPassword" -}}
{{- randAlphaNum 9 -}}{{- randNumeric 1 -}}
{{- end -}}

{{/*
Get the user supplied password or use a random string
*/}}
{{- define "vizivault-platform.password" -}}
{{- $password := .Values.vizivault.admin.password -}}
{{- default (include "vizivault-platform.randomPassword" .) $password -}}
{{- end -}}

{{/*
Generate name
*/}}
{{- define "vizivault-platform.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vizivault-platform.fullname" -}}
{{- printf "%s-%s" .root.Release.Name .app | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "vizivault-platform.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the image name
*/}}
{{- define "vizivault-platform.image" -}}
{{- printf "%s/%s:%s" .root.global.registry .app.repository .app.tag -}}
{{- end -}}

{{/*
Return the pull secrets
*/}}
{{- define "vizivault-platform.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "global" .Values.global) -}}
{{- end -}}

{{/*
Returns the fully qualified service name for MongoDB
*/}}
{{- define "vizivault-platform.mongodb.fullname" -}}
{{- printf "%s-%s" .Release.Name "mongodb" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the MongoDB Database Host
*/}}
{{- define "vizivault-platform.databaseHost" -}}
{{- if .Values.mongodb.enabled }}
    {{- printf "%s" (include "vizivault-platform.mongodb.fullname" .) -}}
{{- else -}}
    {{- printf "%s" .Values.database.host -}}
{{- end -}}
{{- end -}}

{{/*
Return the MongoDB Port
*/}}
{{- define "vizivault-platform.databasePort" -}}
{{- if .Values.mongodb.enabled }}
    {{- printf "%d" (.Values.mongodb.service.port | int) -}}
{{- else -}}
    {{- printf "%d" (.Values.database.port | int ) -}}
{{- end -}}
{{- end -}}

{{/*
Return the MongoDB User
*/}}
{{- define "vizivault-platform.databaseUser" -}}
{{- if .Values.mongodb.enabled }}
    {{- printf "%s" .Values.mongodb.auth.username -}}
{{- else -}}
    {{- printf "%s" .Values.database.username -}}
{{- end -}}
{{- end -}}

{{/*
Return the MongoDB Secret Name
*/}}
{{- define "vizivault-platform.databaseSecretName" -}}
{{- if .Values.mongodb.enabled }}
    {{- printf "%s" (include "vizivault-platform.mongodb.fullname" .) -}}
{{- else -}}
    {{- printf "%s" "vizivault-platform-secrets" -}}
{{- end -}}
{{- end -}}


{{/*
Return the MongoDB Auth DB
*/}}
{{- define "vizivault-platform.authDb" -}}
{{- if .Values.mongodb.enabled }}
    {{- printf "%s" ( .Values.mongodb.auth.database ) -}}
{{- else -}}
    {{- printf "%s" ( .Values.database.authDb ) -}}
{{- end -}}
{{- end -}}

{{/*
Return the MongoDB URI
*/}}
{{- define "vizivault-platform.databaseURI" -}}

{{- $username := include "vizivault-platform.databaseUser" .root -}}
{{- $host := include "vizivault-platform.databaseHost" .root -}}
{{- $port := include "vizivault-platform.databasePort" .root | int -}}
{{- $database := .db -}}
{{- $authSource := include "vizivault-platform.authDb" .root -}}
{{- $options := "" -}}

{{- range $k, $v := .root.Values.database.options -}}
  {{- $option := printf "&%s=%v" $k $v -}}
  {{- $options = print $options $option -}}
{{- end -}}

{{
    printf "mongodb://%s:$(DATABASE_PASSWORD)@%s:%d/%s?authSource=%s%s"
    $username
    $host
    $port
    $database
    $authSource
    $options
}}
{{- end -}}

{{/*
Returns the fully qualified service name for RabbitMQ
*/}}
{{- define "vizivault-platform.rabbitmq.fullname" -}}
{{- printf "%s-%s" .Release.Name "rabbitmq" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Return the RabbitMQ Host Name
*/}}
{{- define "vizivault-platform.rabbitHost" -}}
{{- if .Values.rabbitmq.enabled }}
    {{- printf "%s-headless" (include "vizivault-platform.rabbitmq.fullname" .) -}}
{{- else -}}
    {{- printf "%s" .Values.rabbit.host -}}
{{- end -}}
{{- end -}}

{{/*
Return the RabbitMQ Port
*/}}
{{- define "vizivault-platform.rabbitPort" -}}
{{- if .Values.rabbitmq.enabled }}
    {{- printf "%d" (.Values.rabbitmq.service.port | int) -}}
{{- else -}}
    {{- printf "%d" (.Values.rabbit.port | int ) -}}
{{- end -}}
{{- end -}}

{{/*
Return the RabbitMQ User
*/}}
{{- define "vizivault-platform.rabbitUser" -}}
{{- if .Values.rabbitmq.enabled }}
    {{- printf "%s" .Values.rabbitmq.auth.username -}}
{{- else -}}
    {{- printf "%s" .Values.rabbit.username -}}
{{- end -}}
{{- end -}}

{{/*
Return the RabbitMQ Secret Name
*/}}
{{- define "vizivault-platform.rabbitSecretName" -}}
{{- if .Values.rabbitmq.enabled }}
    {{- printf "%s" (include "vizivault-platform.rabbitmq.fullname" .) -}}
{{- else -}}
    {{- printf "%s" "vizivault-platform-secrets" -}}
{{- end -}}
{{- end -}}

{{/*
Return the RabbitMQ Virtual Host
*/}}
{{- define "vizivault-platform.rabbitVirtualHost" -}}
{{- if .Values.rabbitmq.enabled }}
    {{- printf "%s" "/" -}}
{{- else -}}
    {{- printf "%s" ( .Values.rabbit.virtualHost ) -}}
{{- end -}}
{{- end -}}

{{/*
Return the RabbitMQ SSL Boolean
*/}}
{{- define "vizivault-platform.rabbitSSL" -}}
{{- if .Values.rabbitmq.enabled }}
    {{- printf "%t" .Values.rabbitmq.auth.tls.enabled -}}
{{- else -}}
    {{- printf "%t" .Values.rabbit.useSSL -}}
{{- end -}}
{{- end -}}

{{/*
Define the external url for the webapp
*/}}
{{- define "vizivault-platform.appUrl" -}}
{{- if .Values.ingress.web.tls.enabled -}}
    {{- printf "https://%s" .Values.ingress.web.domain -}}
{{- else -}}
    {{- printf "http://%s" .Values.ingress.web.domain -}}
{{- end -}}
{{- end -}}

{{/*
Define the external url for the api
*/}}
{{- define "vizivault-platform.apiUrl" -}}
{{- if .Values.ingress.api.tls.enabled -}}
    {{- printf "https://%s" .Values.ingress.api.domain -}}
{{- else -}}
    {{- printf "http://%s" .Values.ingress.api.domain -}}
{{- end -}}
{{- end -}}