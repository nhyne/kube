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

command files: {
  task: {
    "\(obj.metadata.name)-\(strings.ToLower(obj.kind))": file.Create & {
      Namespace = *obj.metadata.namespace | "cluster"
      filename: "./services-cue/\(obj.metadata.labels.env)/\(Namespace)/\(obj.metadata.name)-\(strings.ToLower(obj.kind)).yml"
      contents: yaml.Marshal(obj)
    } for obj in objects
  }
}
