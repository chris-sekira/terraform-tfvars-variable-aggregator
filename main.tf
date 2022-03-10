terraform {
  required_version = ">= 1.1.0"

  required_providers {
    tfvars = {
      source = "innovationnorway/tfvars"
      version = "0.0.1"
    }
  }
}

locals {
  normalized_tfvars_directory = trimsuffix(var.tfvars_directory, "/")
  tfvars_files = tolist(fileset(local.normalized_tfvars_directory, "*.tfvars"))
}

data "tfvars_file" "tfvars_files" {
  count = length(local.tfvars_files)
  filename = format("%s/%s", local.normalized_tfvars_directory, local.tfvars_files[count.index])
}

locals {
  all_variables = {for tfvars_file in data.tfvars_file.tfvars_files : trimspace(regex("^(\\w+)\\.tfvars$", basename(tfvars_file.filename))[0]) => tfvars_file.variables}
}