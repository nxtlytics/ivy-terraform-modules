resource "datadog_dashboard" "docker_resource_utilization" {
  is_read_only = false
  layout_type  = "ordered"
  notify_list  = []
  title        = "Docker Resource Utilization"

  template_variable {
    default = "*"
    name    = "image_name"
    prefix  = "image_name"
  }
  template_variable {
    default = var.default_environment
    name    = "env"
    prefix  = "${var.namespace}_environment"
  }
  template_variable {
    default = "*"
    name    = "image_tag"
    prefix  = "image_tag"
  }

  widget {
    layout = {}

    toplist_definition {
      time  = {}
      title = "Docker images using the most memory"

      request {
        q = "top(max:docker.mem.rss{$env,$image_name,$image_tag} by {image_name}, 50, 'max', 'desc')"

        style {
          palette = "warm"
        }
      }
    }
  }
  widget {
    layout = {}

    toplist_definition {
      time  = {}
      title = "Docker images with the highest memory limits"

      request {
        q = "top(max:docker.mem.limit{$env,$image_name,$image_tag} by {image_name}, 50, 'max', 'desc')"

        style {
          palette = "orange"
        }
      }
    }
  }
  widget {
    layout = {}

    toplist_definition {
      time  = {}
      title = "Docker images with the most wasted memory (mesos allocated vs used) [use json..."

      request {
        q = "max:docker.mem.limit{$env} by {image_name}-(max:docker.mem.rss{$env} by {image_name}+max:docker.mem.cache{$env} by {image_name})"

        conditional_formats {
          comparator = ">="
          hide_value = false
          palette    = "white_on_red"
          value      = 600000000
        }

        style {
          palette = "purple"
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
      title       = "Max Memory RSS by Docker Image"

      request {
        display_type = "line"
        q            = "max:docker.mem.rss{$env,$image_name,$image_tag} by {image_name,image_tag}"
      }
      request {
        display_type = "line"
        q            = "max:docker.mem.cache{$env,$image_name,$image_tag} by {image_name,image_tag}"
      }
      request {
        display_type = "line"
        q            = "max:docker.mem.in_use{$env,$image_name,$image_tag} by {image_name,image_tag}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Max Docker User CPU by Docker Image"

      request {
        display_type = "line"
        q            = "top(max:docker.cpu.user{$env,$image_name,$image_tag} by {image_name}, 10, 'mean', 'desc')"

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
      title       = "Docker image CPU utilization (%) by host"

      request {
        display_type = "line"
        q            = "avg:docker.cpu.user{$env,$image_tag,$image_name,${var.namespace}_service:mesosagent} by {host}"

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
      title       = "Docker Memory Limit Utilization"

      request {
        display_type = "line"
        q            = "max:docker.mem.rss{$image_name,$env,$image_tag} by {image_name,image_tag}+max:docker.mem.cache{$image_name,$env,$image_tag} by {image_name,image_tag}"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }
      request {
        display_type = "line"
        q            = "max:docker.mem.limit{$image_name,$env,$image_tag} by {image_tag}"

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
      title       = "Total Mem Used Across all Slaves"

      request {
        display_type = "area"
        q            = "max:docker.mem.rss{$image_name,$env,$image_tag} by {host}+max:docker.mem.cache{$image_name,$env,$image_tag} by {host}"

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
      title       = "Docker Network Usage"

      request {
        display_type = "line"
        q            = "sum:docker.net.bytes_rcvd{$env,$image_name,$image_tag,!image_name:gliderlabs/registrator,!image_name:nxtlytics/ec2metaproxy} by {image_name}"

        style {
          palette = "dog_classic"
        }
      }
      request {
        display_type = "line"
        q            = "-sum:docker.net.bytes_sent{$env,$image_name,$image_tag,!image_name:gliderlabs/registrator,!image_name:nxtlytics/ec2metaproxy} by {image_name}"

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
      title       = "mesos.slave.tasks_killed, mesos.slave.tasks_failed, mesos.slave.tasks_lost"

      request {
        display_type = "bars"
        q            = "sum:mesos.slave.tasks_killed{$env}.as_count()"
      }
      request {
        display_type = "bars"
        q            = "sum:mesos.slave.tasks_failed{$env}.as_count()"
      }
      request {
        display_type = "bars"
        q            = "sum:mesos.slave.tasks_lost{$env}.as_count()"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Sum of marathon.tasksStaged over $env by app_id"

      request {
        display_type = "bars"
        q            = "sum:marathon.tasksStaged{$env} by {app_id}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Service within 500MB of their memory limit"

      request {
        display_type = "line"
        q            = "max:docker.mem.limit{$env} by {image_name}-max:docker.mem.in_use{$env} by {image_name}"
      }

      yaxis {
        include_zero = false
        max          = "500000000"
      }
    }
  }
}
