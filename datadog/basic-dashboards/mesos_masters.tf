resource "datadog_dashboard" "mesos_masters" {
  is_read_only = false
  layout_type  = "ordered"
  notify_list  = []
  title        = "Mesos Masters"

  template_variable {
    default = var.default_environment
    name    = "env"
    prefix  = "${var.namespace}_environment"
  }

  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "System Load 1 by Host"

      request {
        display_type = "line"
        q            = "avg:system.load.1{$env,${var.namespace}_service:mesosmaster} by {host}"

        style {
          line_width = "normal"
        }
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "System CPU by Host"

      request {
        display_type = "line"
        q            = "avg:system.cpu.user{$env,${var.namespace}_service:mesosmaster} by {host}"

        style {
          line_width = "normal"
        }
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "System Disk IO"

      request {
        display_type = "line"
        q            = "avg:system.io.w_s{$env,${var.namespace}_service:mesosmaster} by {host}"
      }
      request {
        display_type = "line"
        q            = "- avg:system.io.r_s{$env,${var.namespace}_service:mesosmaster} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "Max of system.cpu.iowait over ${var.namespace}_service:mesosmaster,$env by host"

      request {
        display_type = "line"
        q            = "max:system.cpu.iowait{${var.namespace}_service:mesosmaster,$env} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "System Network IO"

      request {
        display_type = "area"
        q            = "sum:system.net.bytes_rcvd{$env,${var.namespace}_service:mesosmaster} by {host}"
      }
      request {
        q = "-sum:system.net.bytes_sent{$env,${var.namespace}_service:mesosmaster}by{host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "Avg of system.mem.free over $env,${var.namespace}_service:mesosmaster by host"

      request {
        display_type = "line"
        q            = "avg:system.mem.free{$env,${var.namespace}_service:mesosmaster} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "Disk Free"

      request {
        display_type = "line"
        q            = "max:system.disk.free{$env,${var.namespace}_service:mesosmaster} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "Avg of zookeeper.watch_count over $env,${var.namespace}_service:mesosmaster by host"

      request {
        display_type = "line"
        q            = "avg:zookeeper.watch_count{$env,${var.namespace}_service:mesosmaster} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "Zookeeper ZXID changes/s"

      request {
        display_type = "line"
        q            = "per_second(max:zookeeper.zxid.count{$env,${var.namespace}_service:mesosmaster} by {host})"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "Max of zookeeper.nodes over $env,${var.namespace}_service:mesosmaster by host"

      request {
        display_type = "line"
        q            = "max:zookeeper.nodes{$env,${var.namespace}_service:mesosmaster} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "Max of zookeeper.latency.avg over $env,${var.namespace}_service:mesosmaster by host"

      request {
        display_type = "line"
        q            = "max:zookeeper.latency.avg{$env,${var.namespace}_service:mesosmaster} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "Max of zookeeper.outstanding_requests over $env,${var.namespace}_service:mesosmaster by host"

      request {
        display_type = "line"
        q            = "max:zookeeper.outstanding_requests{$env,${var.namespace}_service:mesosmaster} by {host}"
      }
    }
  }
  widget {
    layout = {}

    toplist_definition {
      time  = {}
      title = "Zookeeper Leader"

      request {
        q = "count:zookeeper.instances{$env,${var.namespace}_service:mesosmaster} by {host,mode}"

        style {
          palette = "dog_classic"
        }
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "aws.ec2.cpucredit_usage, aws.ec2.cpucredit_balance"

      request {
        display_type = "line"
        q            = "max:aws.ec2.cpucredit_usage{$env,${var.namespace}_service:mesosmaster} by {host}"

        style {
          palette = "warm"
        }
      }
      request {
        display_type = "line"
        q            = "max:aws.ec2.cpucredit_balance{$env,${var.namespace}_service:mesosmaster} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "Max of consul.raft.leader.lastContact.max over $env,${var.namespace}_service:mesosmaster by..."

      request {
        display_type = "area"
        q            = "max:consul.raft.leader.lastContact.max{$env,${var.namespace}_service:mesosmaster} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      show_legend = false
      time        = {}
      title       = "Avg of consul.fsm.kvs.set.count over $env,${var.namespace}_service:mesosmaster"

      request {
        display_type = "bars"
        q            = "avg:consul.fsm.kvs.set.count{$env,${var.namespace}_service:mesosmaster}.as_count()"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }
    }
  }
}
