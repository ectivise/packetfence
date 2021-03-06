// generated by directives_generate.go; DO NOT EDIT

package core

import (
	// Include all plugins.
	_ "github.com/mholt/caddy/startupshutdown"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/auto"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/bind"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/cache"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/chaos"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/debug"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/dnssec"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/dnstap"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/erratic"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/errors"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/etcd"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/file"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/health"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/hosts"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/loadbalance"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/log"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/logger"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/metrics"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/pfdns"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/pprof"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/proxy"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/reverse"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/rewrite"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/root"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/secondary"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/tls"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/trace"
	_ "github.com/inverse-inc/packetfence/go/coredns/plugin/whoami"
)
