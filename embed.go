package usstates

import (
	_ "embed"
)

//go:embed us-states-timezones.pb
var FullData []byte

//go:embed us-states-timezones.reduce.pb
var LiteData []byte

//go:embed us-states-timezones.reduce.compress.pb
var LiteCompressData []byte

//go:embed us-states-timezones.reduce.preindex.pb
var PreindexData []byte
