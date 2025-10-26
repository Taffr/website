

# Deploy steps (because you will probably forget)

0. Make sure that you have both gcloud-cli and terraform installed
1. Make your changes.
2. Run `npm run push-image`, this will build *and* push the image to registry repository (see main.tf)
3. Note the output date of the image.
4. Update the terraform (main.tf) with the new name of image on the "default" cloud run resource.
5. Terraform apply
6. Done!



# Import terraform state
Because I am lazy and I can't bother right now to host the state in bucket, there is a simple import tool called
`import-terraform.sh` that creates some state.
