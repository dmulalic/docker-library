#!/bin/bash
set -e

exec "${CATALINA_HOME}/bin/catalina.sh" run
exec "${KC_HOME}/bin/standalone.sh" -Djboss.socket.binding.port-offset=10
