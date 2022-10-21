# Integration of cgroups with PBS job scheduler for GPU resource isolation

This project was a hotfix to enable GPU isolation for multiple PBS jobs running on the same multi-GPU node.

It was not possible to implement the standard cgroups extensions in PBS across the whole cluster as it was already in production.

PBS hooks assign GPUs within the node to each job and then create cgroups to isolate those GPUs from other jobs running on the node.
