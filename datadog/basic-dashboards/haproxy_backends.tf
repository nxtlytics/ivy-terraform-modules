resource "datadog_dashboard" "haproxy_backends" {
  is_read_only = false
  layout_type  = "ordered"
  notify_list  = []
  title        = "Haproxy Backends"

  template_variable {
    default = "appdev"
    name    = "env"
    prefix  = "${var.namespace}_environment"
  }
  template_variable {
    default = "*"
    name    = "scope"
  }

  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Session Rate by Service"

      request {
        display_type = "line"
        q            = "sum:haproxy.backend.session.rate{$env,$scope} by {service}"

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
      title       = "Incoming Network Traffic by Service"

      request {
        display_type = "line"
        q            = "sum:haproxy.backend.bytes.in_rate{$env,$scope} by {service}"

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
      title       = "Outgoing Network Traffic by Service"

      request {
        display_type = "line"
        q            = "sum:haproxy.backend.bytes.out_rate{$env,$scope} by {service}"

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
      title       = "Max Response Time by Service"

      request {
        display_type = "line"
        q            = "max:haproxy.backend.response.time{$env,$scope} by {service}"

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
      title       = "Services with most 50x codes"

      request {
        display_type = "bars"
        q            = "sum:haproxy.backend.response.5xx{$env,$scope} by {service}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Services with most 4xx codes"

      request {
        display_type = "bars"
        q            = "sum:haproxy.backend.response.4xx{$env,$scope} by {service}"

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
      title       = "Sum of haproxy.frontend.session.rate over $env,$scope,${var.namespace}_service:mesosagent b..."

      request {
        display_type = "area"
        q            = "sum:haproxy.frontend.session.rate{$env,$scope,${var.namespace}_service:mesosagent} by {service}"

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
      title       = "Queue Time By Service"

      request {
        display_type = "line"
        q            = "max:haproxy.backend.queue.time{$env,$scope,${var.namespace}_service:mesosagent} by {service}"

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
      title       = "Backend Session Capacity (%)"

      request {
        display_type = "line"
        q            = "max:haproxy.backend.session.pct{$env,$scope,${var.namespace}_service:mesosagent} by {service}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Backend Session Capacity by Host (%)"

      request {
        display_type = "line"
        q            = "max:haproxy.backend.session.pct{$env,$scope,${var.namespace}_service:mesosagent} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Backend Sessions (count, per node)"

      request {
        display_type = "line"
        q            = "max:haproxy.backend.session.current{$env,$scope} by {service}"

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
      title       = "Backend Sessions (count, all hosts)"

      request {
        display_type = "line"
        q            = "sum:haproxy.backend.session.current{$env,$scope} by {service}"

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
      title       = "Frontend Session Capacity by Host (%)"

      request {
        display_type = "line"
        q            = "max:haproxy.frontend.session.pct{$env,$scope,${var.namespace}_service:mesosagent} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Max of haproxy.backend.bytes.out_rate over $env,$scope by host"

      request {
        display_type = "line"
        q            = "max:haproxy.backend.bytes.out_rate{$env,$scope} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Max of haproxy.backend.bytes.in_rate over $env,$scope by host"

      request {
        display_type = "line"
        q            = "max:haproxy.backend.bytes.in_rate{$env,$scope} by {host}"
      }
    }
  }
  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Sum of haproxy.frontend.session.rate over $env,$scope,${var.namespace}_service:mesosagent b..."

      request {
        display_type = "line"
        q            = "sum:haproxy.frontend.session.rate{$env,$scope,${var.namespace}_service:mesosagent} by {host}"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }
    }
  }
}
