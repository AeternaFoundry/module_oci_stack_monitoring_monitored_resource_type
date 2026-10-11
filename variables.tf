variable "stack_monitoring_monitored_resource_types" {
  description = <<EOT
Map of stack_monitoring_monitored_resource_types, attributes below
Required:
    - compartment_id
    - name
Optional:
    - defined_tags
    - description
    - display_name
    - freeform_tags
    - metric_namespace
    - resource_category
    - source_type
    - metadata (block):
        - agent_properties (optional)
        - format (required)
        - required_properties (optional)
        - unique_property_sets (optional, block):
            - properties (required)
        - valid_properties_for_create (optional)
        - valid_properties_for_update (optional)
        - valid_property_values (optional)
        - valid_sub_resource_types (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    compartment_id    = string
    name              = string
    defined_tags      = optional(map(string))
    description       = optional(string)
    display_name      = optional(string)
    freeform_tags     = optional(map(string))
    metric_namespace  = optional(string)
    resource_category = optional(string)
    source_type       = optional(string)
    metadata = optional(object({
      agent_properties    = optional(list(string))
      format              = string
      required_properties = optional(list(string))
      unique_property_sets = optional(list(object({
        properties = list(string)
      })))
      valid_properties_for_create = optional(list(string))
      valid_properties_for_update = optional(list(string))
      valid_property_values       = optional(map(string))
      valid_sub_resource_types    = optional(list(string))
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.stack_monitoring_monitored_resource_types : (
        v.metadata == null || (contains([for v in ["SYSTEM_FORMAT"] : lower(v)], lower(v.metadata.format)))
      )
    ])
    error_message = "must be one of: \"SYSTEM_FORMAT\""
  }
}

