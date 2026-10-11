resource "oci_stack_monitoring_monitored_resource_type" "stack_monitoring_monitored_resource_types" {
  for_each = var.stack_monitoring_monitored_resource_types

  compartment_id    = each.value.compartment_id
  name              = each.value.name
  defined_tags      = each.value.defined_tags
  description       = each.value.description
  display_name      = each.value.display_name
  freeform_tags     = each.value.freeform_tags
  metric_namespace  = each.value.metric_namespace
  resource_category = each.value.resource_category
  source_type       = each.value.source_type

  dynamic "metadata" {
    for_each = each.value.metadata != null ? [each.value.metadata] : []
    content {
      agent_properties    = metadata.value.agent_properties
      format              = metadata.value.format
      required_properties = metadata.value.required_properties
      dynamic "unique_property_sets" {
        for_each = metadata.value.unique_property_sets != null ? metadata.value.unique_property_sets : []
        content {
          properties = unique_property_sets.value.properties
        }
      }
      valid_properties_for_create = metadata.value.valid_properties_for_create
      valid_properties_for_update = metadata.value.valid_properties_for_update
      valid_property_values       = metadata.value.valid_property_values
      valid_sub_resource_types    = metadata.value.valid_sub_resource_types
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

