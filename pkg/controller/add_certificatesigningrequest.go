package controller

import (
	"github.com/horis233/kubelet-server-csr-approver/pkg/controller/certificatesigningrequest"
)

func init() {
	// AddToManagerFuncs is a list of functions to create controllers and add them to a manager.
	AddToManagerFuncs = append(AddToManagerFuncs, certificatesigningrequest.Add)
}