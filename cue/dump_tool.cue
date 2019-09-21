package kube

import (
	"encoding/yaml"
	"tool/cli"
	"tool/file"
	"strings"
)

command dump: {
	task print: cli.Print & {
		text: yaml.MarshalStream(objects)
	}
}

// If there is an issue with "kind" missing, it's because one of the things getting templated has a matching name
// TODO: Get "cluster" stuff into subfolders
command files: {
	task: {
		for obj in objects {
			"\(obj.metadata.name)-\(strings.ToLower(obj.kind))-\(obj.metadata.labels.env)": file.Create & {
				Namespace = *obj.metadata.namespace | "cluster"
				filename: "./services/\(obj.metadata.labels.env)/\(Namespace)/\(obj.metadata.name)-\(strings.ToLower(obj.kind)).yml"
				contents: yaml.Marshal(obj)
			}
		}
	}
}
