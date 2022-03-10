variable "tfvars_directory" {
  type = string
  description = "Path to the directory containing the .tfvars files"
  validation {
    condition = length(fileset(format("%s/", trimsuffix(var.tfvars_directory, "/")), "*.tfvars")) > 0
    error_message = "The .tfvars directory either does not exist, or does not contain any .tfvars files."
  }
}