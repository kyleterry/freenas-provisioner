package main

import (
	"github.com/kyleterry/freenas-provisioner/pkg/cli"
)

const (
	AppName = "freenas-provisioner"
	AppDesc = "Kubernetes Freenas Provisioner (NFS)"
)

var (
	AppVersion string
)

func main() {
	if AppVersion == "" {
		AppVersion = "master"
	}

	cli.Process(AppName, AppDesc, AppVersion)
}
