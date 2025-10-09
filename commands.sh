gcloud compute addresses create google-managed-services-default \
    --global \
    --prefix-length=16 \
    --description="Private IP range for Google-managed services" \
    --network=default



gcloud services vpc-peerings connect \
    --service=servicenetworking.googleapis.com \
    --ranges=google-managed-services-default \
    --network=default


gcloud sql instances patch state-sqlmesh \
    --network=default \
    --enable-google-private-path


# Example: Patching an existing instance to enable PSC
# This might require removing existing private IP configuration first.
# It's often cleaner to create a new instance with PSC enabled from the start.
gcloud sql instances patch state-sqlmesh \
    --enable-private-service-connect \
    --psc-service-attachment-limit=1


# First, get the service attachment URI from your Cloud SQL instance
# This URI will be available after you enable PSC on the instance.
# You can find it by describing the instance:
# gcloud sql instances describe state-sqlmesh --format="value(pscServiceAttachments[0].serviceAttachmentUri)"
gcloud compute addresses create cloudsql-psc-ip \
    --region=europe-west9 \
    --subnet=default \
    --addresses=10.200.0.5 \
    --purpose=PRIVATE_SERVICE_CONNECT \
    --network=default \
    --project=data-pocs-474613 \
    --description="Internal static IP for Cloud SQL PSC endpoint"



gcloud compute forwarding-rules create cloudsql-psc-endpoint \
    --region=europe-west9 \
    --network=default \
    --address=10.200.0.5 \
    --target-service-attachment=projects/ab9f99033a005e425p-tp/regions/europe-west9/serviceAttachments/a-8590a0c5e9d9-psc-service-attachment-68e7335158a4444e \
    --network=projects/data-pocs-474613/global/networks/default \
    --network-tier=PREMIUM \
    --description="PSC endpoint for Cloud SQL instance state-sqlmesh"




gcloud sql instances describe state-sqlmesh \
    --project=data-pocs-474613 \
    --format="value(pscServiceAttachmentLink)"



gcloud compute instances describe instance-sqlmesh-poc --zone=YOUR_VM_ZONE --format="value(serviceAccounts[0].email)"



gcloud projects add-iam-policy-binding data-pocs-474613 \
    --member="serviceAccount:490472061909-compute@developer.gserviceaccount.com" \
    --role="roles/cloudsql.client"
    --role="roles/cloudsql.client"

nohup ./cloud_sql_proxy -instances=data-pocs-474613:europe-west9:state-sqlmesh=tcp:5432 > cloud_sql_proxy.log 2>&1 &


ps aux | grep cloud_sql_proxy


psql -h 127.0.0.1 -p 5432 -U postgres -d sqlmesh_state
