resource "datadog_dashboard" "aws_cpu_credits" {
  is_read_only = false
  layout_type  = "ordered"
  notify_list  = []
  title        = "AWS CPU Credits"

  widget {
    layout = {}

    timeseries_definition {
      legend_size = "0"
      show_legend = false
      time        = {}
      title       = "Min of aws.ec2.cpucredit_balance over * by host,${var.namespace}_environment"

      request {
        display_type = "line"
        q            = "min:aws.ec2.cpucredit_balance{*} by {host,${var.namespace}_environment}"

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
      title       = "Min of aws.rds.cpucredit_balance over * by dbinstanceidentifier"

      request {
        display_type = "line"
        q            = "min:aws.rds.cpucredit_balance{*} by {dbinstanceidentifier}"

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
