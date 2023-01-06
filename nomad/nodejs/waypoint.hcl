# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

project = "nomad-nodejs"

app "nomad-nodejs-web" {

  runner {
    enabled = true

    data_source "git" {
      url  = "https://github.com/MarkusBansky/waypoint-examples.git"
      path = "nomad/nodejs"
    }
  }


  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "${var.docker_host}/nomad-nodejs-web"
        tag   = "1"
        local = false
        auth {
          username = var.docker_user
          password = var.docker_pass
        }
      }
    }
  }

  deploy {
    use "nomad" {
      // these options both default to the values shown, but are left here to
      // show they are configurable
      datacenter = "dc1"
      namespace  = "default"
    }
  }

}
