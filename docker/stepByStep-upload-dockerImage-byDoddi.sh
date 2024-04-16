#/bin/bash
gcloud init
gcloud auth login
gcloud config set project iam-bicarait
gcloud components update

export GCP_REGION='asia-southeast2'
export GCP_PROJECT='iam-bicarait'
export AR_REPO='wordpress-on-cloudstorage'  
export SERVICE_NAME='cr-wordpress' 

#gcloud artifacts repositories create "$AR_REPO" --location="$GCP_REGION" --repository-format=Docker
gcloud auth configure-docker "$GCP_REGION-docker.pkg.dev"
gcloud builds submit --tag "$GCP_REGION-docker.pkg.dev/$GCP_PROJECT/$AR_REPO/$SERVICE_NAME"

#deploy automatically to update existing 
gcloud run deploy "$SERVICE_NAME" \
   --image="$GCP_REGION-docker.pkg.dev/$GCP_PROJECT/$AR_REPO/$SERVICE_NAME" \
   --port=80 \
   --allow-unauthenticated \
   --region=$GCP_REGION \
   --platform=managed  \
   --project=$GCP_PROJECT \
   --set-env-vars=GCP_PROJECT=$GCP_PROJECT,GCP_REGION=$GCP_REGION

#Result: 
#https://cr-wordpress-kcy2izlq7q-et.a.run.app