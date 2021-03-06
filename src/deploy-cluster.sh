VNET=vnet
SUBNET=aks-subnet
RG=teamResources
REGION=northeurope
AKS_VERSION=1.9.16
CLUSTER_NAME=team4-openhack

#az network vnet subnet create --resource-group $RG --vnet-name $VNET --name $SUBNET --address-prefixes 10.2.1.0/24

SUBNET_ID=$(az network vnet subnet show -g $RG --vnet-name $VNET --name $SUBNET --query id -o tsv)

az aks create \
--resource-group $RG \
--name $CLUSTER_NAME \
--enable-aad \
--aad-admin-group-object-ids da45e6e8-2398-4508-a940-e3cfa4a171de \
--aad-tenant-id 7a74343b-eb48-4f2d-984c-65b4f8f1566d \
--node-count 2 \
--load-balancer-sku standard \
--location $REGION \
--network-plugin azure \
--vnet-subnet-id $SUBNET_ID \
--service-cidr 10.240.0.0/24 \
--dns-service-ip 10.240.0.10 \
--docker-bridge-address 172.17.0.1/16 \
--generate-ssh-keys

#attach the ACR to the cluster so the cluster can pull images from our repo
az aks update --name team4-openhack --attach-acr registrykna5332 -g teamResources