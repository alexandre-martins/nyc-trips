while getopts ":n:" opt; do
  case $opt in
    n)
      echo "Trying to create bucket with name: $OPTARG"
      aws s3 mb s3://$OPTARG
      echo "Loading files into bucket..."
      aws s3 cp data/data-vendor_lookup-csv.csv s3://$OPTARG
      aws s3 cp data/data-payment_lookup-csv.csv s3://$OPTARG
      aws s3 cp data/data-sample_data-nyctaxi-trips-2009-json_corrigido.json s3://$OPTARG
      aws s3 cp data/data-sample_data-nyctaxi-trips-2010-json_corrigido.json s3://$OPTARG
      aws s3 cp data/data-sample_data-nyctaxi-trips-2011-json_corrigido.json s3://$OPTARG
      aws s3 cp data/data-sample_data-nyctaxi-trips-2012-json_corrigido.json s3://$OPTARG
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done
