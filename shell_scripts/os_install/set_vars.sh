export DISK0=/dev/disk/by-id/nvme-WDC_CL_SN720_SDAQNTW-512G-2000_21060X802821
export DISK1=/dev/disk/by-id/nvme-WDC_CL_SN720_SDAQNTW-512G-2000_21060X801103
#export UUID=asdkpm
export UUID=$(dd if=/dev/urandom bs=1 count=100 2>/dev/null | tr -dc 'a-z0-9' | cut -c-6)
