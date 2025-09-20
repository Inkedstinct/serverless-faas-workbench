for dir in */; do
  dir=${dir%/}   # remove trailing /
  suffix=${dir##*-}   # get part after the last '-'

  yaml="$dir/service.yaml"

  # Update metadata.name
  yq -i ".metadata.name = \"$dir\"" "$yaml"

  # If suffix is cold → add imagePullPolicy: Always to the first container
  if [ "$suffix" = "cold" ]; then
    yq -i '.spec.template.spec.containers[0].imagePullPolicy = "Always"' "$yaml"
  fi
done
