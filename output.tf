output "variables" {
  description = "Aggregate object of all variables from the source .tfvars files. Composed of keys for each .tfvars filename (without extension) with values from the .tfvars file."
  value = local.all_variables
}