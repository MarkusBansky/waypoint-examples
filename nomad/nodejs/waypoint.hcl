# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

project = "nomad-nodejs"

app "nomad-nodejs-web" {

  runner {
    enabled = true

    data_source "git" {
      url  = "https://github.com/hashicorp/waypoint-examples.git"
      path = "nomad/nodejs"
    }
  }


  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "192.168.1.100:5000/nomad-nodejs-web"
        tag   = "1"
        local = false
        auth {
          username = "admin"
          password = "admin"
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
