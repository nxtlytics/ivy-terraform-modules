resource "datadog_dashboard" "cassandra" {
  is_read_only = false
  layout_type  = "ordered"
  notify_list  = []
  title        = "Cassandra"

  template_variable {
    default = var.default_environment
    name    = "env"
    prefix  = "${var.namespace}_environment"
  }
  template_variable {
    default = var.default_cassandra_cluster
    name    = "cassandra"
    prefix  = "${var.namespace}_service"
  }

  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "CPU"

      request {
        display_type = "line"
        q            = "avg:system.cpu.user{$env,$cassandra} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Avg of system.mem.free over $env,$cassandra by host"

      request {
        display_type = "area"
        q            = "avg:system.mem.free{$env,$cassandra} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Avg of system.load.1 over $env,$cassandra by host"

      request {
        display_type = "line"
        q            = "avg:system.load.1{$env,$cassandra} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Network In"

      request {
        display_type = "area"
        q            = "max:system.net.bytes_rcvd{$env,$cassandra} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Network Out"

      request {
        display_type = "area"
        q            = "max:system.net.bytes_sent{$env,$cassandra} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Disk Read"

      marker {
        display_type = "error dashed"
        label        = "EBS Max R/W"
        value        = "y = 160K"
      }

      request {
        display_type = "line"
        q            = "max:system.io.rkb_s{$env,$cassandra} by {host,device}"

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
      title       = "Disk Write"

      request {
        display_type = "line"
        q            = "max:system.io.wkb_s{$env,$cassandra} by {host,device}"

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
      title       = "IOWait"

      request {
        display_type = "line"
        q            = "max:system.cpu.iowait{$env,$cassandra} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "JVM Heap Memory"

      request {
        display_type = "line"
        q            = "avg:jvm.heap_memory{$env,$cassandra} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Cassandra Write Ops (deprecated!)"

      request {
        display_type = "line"
        q            = "per_second(avg:cassandra.latency.count{$env,$cassandra,clientrequest:write} by {host})"

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
      title       = "Cassandra Ops/sec by type (deprecated?)"

      request {
        display_type = "line"
        q            = "per_second(max:cassandra.latency.count{$env,$cassandra} by {clientrequest})"

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
      title       = "Cassandra Queries/sec by type"

      request {
        display_type = "line"
        q            = "sum:cassandra.latency.one_minute_rate{$env,$cassandra} by {clientrequest}"

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

    hostmap_definition {
      group = [
        "availability-zone",
      ]
      no_group_hosts  = true
      no_metric_hosts = true
      scope = [
        "$env",
        "$cassandra",
      ]
      title = "Avg of system.load.1 over $env,$cassandra by host"

      request {
        fill {
          q = "avg:system.load.1{$env,$cassandra} by {host}"
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

    change_definition {
      time  = {}
      title = "Max of system.disk.used over $env,$cassandra by host"

      request {
        change_type   = "absolute"
        compare_to    = "day_before"
        increase_good = true
        order_by      = "change"
        order_dir     = "desc"
        q             = "max:system.disk.used{$env,$cassandra} by {host}"
        show_present  = true
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Disk free"

      request {
        display_type = "line"
        q            = "min:system.disk.free{$env,$cassandra,device:/dev/nvme1n1} by {host}"

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
      title       = "Total Cassandra Disk Usage"

      request {
        display_type = "area"
        q            = "sum:system.disk.used{$env,$cassandra} by {host}"
      }
      request {
        display_type = "line"
        q            = "sum:system.disk.total{$env,$cassandra}"
      }
      request {
        display_type = "line"
        q            = "sum:system.disk.used{$env,$cassandra}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Cassandra Read Latency (in milliseconds)"

      request {
        display_type = "line"
        q            = "per_second(max:cassandra.latency.one_minute_rate{$env,$cassandra,clientrequest:read} by {host})"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Cassandra Write Latency (in milliseconds)"

      request {
        display_type = "line"
        q            = "( diff(max:cassandra.total_latency.count{$env,$cassandra,clientrequest:write} by {host}) / diff(max:cassandra.latency.count{$env,$cassandra,clientrequest:write} by {host}) ) / 1000"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "JVM GC Time (ParNew, milliseconds)"

      request {
        display_type = "line"
        q            = "per_second(max:jvm.gc.parnew.time{$env,$cassandra} by {host})"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "warm"
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
      title       = "EBS Read Ops"

      request {
        display_type = "line"
        q            = "avg:aws.ebs.volume_read_ops{$env,$cassandra} by {host}.as_count()"

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
      title       = "EBS Write Ops"

      request {
        display_type = "line"
        q            = "avg:aws.ebs.volume_write_ops{$env,$cassandra} by {host}.as_count()"

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
      title       = "EBS Read Latency"

      request {
        display_type = "line"
        q            = "avg:aws.ebs.volume_total_read_time{$env,$cassandra} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "EBS Write Latency"

      request {
        display_type = "line"
        q            = "avg:aws.ebs.volume_total_write_time{$env,$cassandra} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Pending/Active Tasks"

      request {
        display_type = "bars"
        q            = "sum:cassandra.active_tasks{$cassandra,$env} by {threadpools}"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "cool"
        }
      }
      request {
        display_type = "bars"
        q            = "sum:cassandra.pending_tasks{$cassandra,$env} by {threadpools}"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "warm"
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
      title       = "Blocked Tasks"

      request {
        display_type = "area"
        q            = "max:cassandra.currently_blocked_tasks.count{$env,$cassandra} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Dropped Messages (Messages processed after timeout)"

      request {
        display_type = "bars"
        q            = "diff(sum:cassandra.dropped.count{$env,$cassandra} by {droppedmessage,host})"

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
      title       = "Coordinator Scan Latency by Table"

      request {
        display_type = "line"
        q            = "avg:cassandra.coordinator_scan_latency.max{$env,$cassandra} by {table}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Coordinator Read Latency by Table"

      request {
        display_type = "line"
        q            = "avg:cassandra.coordinator_read_latency.max{$env,$cassandra} by {table}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Pending Compactions"

      request {
        display_type = "line"
        q            = "sum:cassandra.pending_compactions{$cassandra,$env} by {table,columnfamily}"

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
      title       = "Disk Space Per Table (?)"

      request {
        display_type = "line"
        q            = "sum:cassandra.live_disk_space_used{$env,$cassandra} by {keyspace}"

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
      title       = "Average Read Latency per Table"

      request {
        display_type = "line"
        q            = "avg:cassandra.read_latency.99th_percentile{$env,$cassandra} by {table}"

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
      title       = "Average Write Latency per Table"

      request {
        display_type = "line"
        q            = "avg:cassandra.write_latency.99th_percentile{$env,$cassandra} by {table}"

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

    toplist_definition {
      time  = {}
      title = "Avg of cassandra.coordinator_read_latency.mean over $env,$cassandra by keyspa..."

      request {
        q = "top(avg:cassandra.coordinator_read_latency.mean{$env,$cassandra} by {keyspace,table}, 10, 'mean', 'desc')"

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
      title = "Avg of cassandra.coordinator_read_latency.max over * by keyspace,table"

      request {
        q = "top(avg:cassandra.coordinator_read_latency.max{*} by {keyspace,table}, 10, 'mean', 'desc')"

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
      title = "Avg of cassandra.coordinator_read_latency.99th_percentile over * by table,key..."

      request {
        q = "top(avg:cassandra.coordinator_read_latency.99th_percentile{*} by {table,keyspace}, 10, 'mean', 'desc')"

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
      title       = "Hints (statements) in Progress"

      request {
        display_type = "area"
        q            = "max:cassandra.hints_succeeded.one_minute_rate{$env,$cassandra} by {host}"

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
      title       = "T2 CPU Credits"

      request {
        display_type = "line"
        q            = "avg:aws.ec2.cpucredit_balance{$env,$cassandra} by {host}"

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
      title       = "AWS EC2 Disk Read Ops"

      request {
        display_type = "line"
        q            = "avg:aws.ec2.disk_read_ops{$env,$cassandra} by {host}.as_count()"

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
      title       = "AWS EC2 Disk Write Ops"

      request {
        display_type = "line"
        q            = "avg:aws.ec2.disk_write_ops{$env,$cassandra} by {host}.as_count()"

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
}
