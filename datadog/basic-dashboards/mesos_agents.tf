resource "datadog_dashboard" "mesos_agents" {
  is_read_only = false
  layout_type  = "ordered"
  notify_list  = []
  title        = "Mesos Agents"

  template_variable {
    default = var.default_environment
    name    = "env"
    prefix  = "${var.namespace}_environment"
  }
  template_variable {
    default = "*"
    name    = "instance_type"
    prefix  = "instance-type"
  }

  widget {
    layout = {}

    hostmap_definition {
      group = [
        "availability-zone",
      ]
      no_group_hosts  = false
      no_metric_hosts = true
      scope = [
        "$env",
        "$instance_type",
        "${var.namespace}_service:mesosagent",
      ]
      title = "Resource Utilization Per Agent (color: cpu / size: mem)"

      request {
        fill {
          q = "max:mesos.slave.cpus_percent{$env,$instance_type,${var.namespace}_service:mesosagent} by {host}"
        }

        size {
          q = "max:mesos.slave.mem_percent{$env,$instance_type,${var.namespace}_service:mesosagent} by {host}"
        }
      }

      style {
        palette      = "green_to_orange"
        palette_flip = false
      }
    }
  }
  widget {
    layout = {}

    toplist_definition {
      time  = {}
      title = "CPU Reserved Percent by Agent"

      request {
        q = "top(max:mesos.slave.cpus_percent{$env,$instance_type,${var.namespace}_service:mesosagent} by {host}, 10, 'mean', 'desc')"

        conditional_formats {
          comparator = ">"
          hide_value = false
          palette    = "white_on_red"
          value      = 0.9
        }

        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    layout = {}

    toplist_definition {
      time  = {}
      title = "Memory Reserved Percent by Agent"

      request {
        q = "top(max:mesos.slave.mem_percent{$env,$instance_type,${var.namespace}_service:mesosagent} by {host}, 10, 'mean', 'desc')"

        conditional_formats {
          comparator = ">"
          hide_value = false
          palette    = "white_on_red"
          value      = 0.9
        }

        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "system.cpu.user"

      request {
        display_type = "line"
        q            = "avg:system.cpu.user{${var.namespace}_service:mesosagent,$env,$instance_type} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Avg of system.load.1 over ${var.namespace}_service:mesosagent,$env,$instance_type by host"

      request {
        display_type = "line"
        q            = "avg:system.load.1{${var.namespace}_service:mesosagent,$env,$instance_type} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "system.cpu.iowait"

      request {
        display_type = "line"
        q            = "avg:system.cpu.iowait{${var.namespace}_service:mesosagent,$env,$instance_type} by {host}"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "system.io.await"

      request {
        display_type = "line"
        q            = "avg:system.io.await{${var.namespace}_service:mesosagent,$env,$instance_type} by {host}"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "system.io.svctm"

      request {
        display_type = "line"
        q            = "avg:system.io.svctm{${var.namespace}_service:mesosagent,$env,$instance_type} by {host}"

        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "system.mem.free"

      request {
        display_type = "line"
        q            = "avg:system.mem.free{${var.namespace}_service:mesosagent,$env,$instance_type} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "system.mem.cached"

      request {
        display_type = "line"
        q            = "avg:system.mem.cached{${var.namespace}_service:mesosagent,$env,$instance_type} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "system.net.bytes_rcvd"

      request {
        display_type = "line"
        q            = "sum:system.net.bytes_rcvd{${var.namespace}_service:mesosagent,$env,$instance_type} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Sum of system.net.bytes_sent over ${var.namespace}_service:mesosagent,$env,$instance_type b..."

      request {
        display_type = "line"
        q            = "sum:system.net.bytes_sent{${var.namespace}_service:mesosagent,$env,$instance_type} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Rootfs Free"

      request {
        display_type = "line"
        q            = "sum:system.disk.free{${var.namespace}_service:mesosagent,$env,$instance_type,device:/dev/nvme1n1} by {host}"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }

      yaxis {
        include_zero = true
        max          = "auto"
        min          = "auto"
        scale        = "linear"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Docker HDD Free"

      request {
        display_type = "line"
        q            = "sum:system.disk.free{${var.namespace}_service:mesosagent,$env,$instance_type,device:/dev/nvme0n1p1} by {host}"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }

      yaxis {
        include_zero = true
        max          = "auto"
        min          = "auto"
        scale        = "linear"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "docker.containers.running"

      request {
        display_type = "line"
        q            = "sum:docker.containers.running{${var.namespace}_service:mesosagent,$env,$instance_type} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Tasks Staging by Host"

      request {
        display_type = "bars"
        q            = "max:mesos.slave.tasks_staging{$env,$instance_type} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Marathon Task Activity"

      request {
        display_type = "bars"
        q            = "max:marathon.tasksStaged{$env,$instance_type} by {app_id}"

        style {
          palette = "cool"
        }
      }
      request {
        display_type = "bars"
        q            = "max:marathon.tasksUnhealthy{$env,$instance_type} by {app_id}"

        style {
          palette = "warm"
        }
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Host count"

      event {
        q = "sources:SNS"
      }

      request {
        display_type = "line"
        q            = "sum:aws.ec2.host_ok{${var.namespace}_service:mesosagent,$env}"
      }
    }
  }
  widget {
    layout = {}

    heatmap_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Max of system.uptime over $env,${var.namespace}_service:mesosagent,$instance_type by host"

      request {
        q = "max:system.uptime{$env,${var.namespace}_service:mesosagent,$instance_type} by {host}"
      }
    }
  }
  widget {
    layout = {}

    heatmap_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Avg of docker.cpu.user over $env,${var.namespace}_service:mesosagent,$instance_type by imag..."

      request {
        q = "avg:docker.cpu.user{$env,${var.namespace}_service:mesosagent,$instance_type} by {image_name,image_tag,host}"
      }
    }
  }
  widget {
    layout = {}

    heatmap_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Max of docker.mem.rss over $env,${var.namespace}_service:mesosagent,$instance_type by image..."

      request {
        q = "max:docker.mem.rss{$env,${var.namespace}_service:mesosagent,$instance_type} by {image_name,image_tag}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Packets"

      request {
        display_type = "area"
        q            = "max:system.net.packets_in.count{$env,$instance_type,${var.namespace}_service:mesosagent} by {host}"

        style {
          palette = "cool"
        }
      }
      request {
        display_type = "area"
        q            = "- max:system.net.packets_out.count{$env,$instance_type,${var.namespace}_service:mesosagent} by {host}"

        style {
          palette = "orange"
        }
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Network Traffic on Mesos Agents"

      request {
        display_type = "area"
        q            = "max:system.net.bytes_rcvd{$env,${var.namespace}_service:mesosagent,$instance_type} by {host}"
      }
      request {
        display_type = "area"
        q            = "- max:system.net.bytes_sent{$env,${var.namespace}_service:mesosagent,$instance_type} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "TIME_WAIT Network Connections"

      request {
        display_type = "line"
        q            = "avg:system.net.tcp4.time_wait{$env,$instance_type,${var.namespace}_service:mesosagent} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "ESTABLISHED Network Connections"

      request {
        display_type = "line"
        q            = "avg:system.net.tcp4.established{$env,$instance_type,${var.namespace}_service:mesosagent} by {host}"
      }
    }
  }
  widget {
    layout = {}

    toplist_definition {
      time  = {}
      title = "Disk Free"

      request {
        q = "top(min:system.disk.free{$env,$instance_type,${var.namespace}_service:mesosagent} by {host}, 50, 'min', 'asc')"

        conditional_formats {
          comparator = "<"
          hide_value = false
          palette    = "white_on_red"
          value      = 5000000000
        }
        conditional_formats {
          comparator = ">"
          hide_value = false
          palette    = "white_on_green"
          value      = 10000000000
        }

        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "ELB Latency"

      request {
        display_type = "line"
        q            = "max:aws.elb.latency{$env} by {availability-zone,host}"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Avg of system.net.tcp.listen_drops over ${var.namespace}_service:mesosagent,$env,$instance_..."

      request {
        display_type = "line"
        q            = "avg:system.net.tcp.listen_drops{${var.namespace}_service:mesosagent,$env,$instance_type} by {host}"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Avg of system.net.tcp.listen_drops over ${var.namespace}_service:mesosagent,$env,$instance_..."

      request {
        display_type = "line"
        q            = "avg:system.net.tcp.listen_drops{${var.namespace}_service:mesosagent,$env,$instance_type} by {host}"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }
    }
  }
}
