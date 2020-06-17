# NYC Taxi Trips

This project is an analysis of the New York City 
taxi trips dataset. 

The data is comprised of:

#### Trips data

- sample_data-nyctaxi-trips-2009-json_corrigido.json
- sample_data-nyctaxi-trips-2010-json_corrigido.json
- sample_data-nyctaxi-trips-2011-json_corrigido.json
- sample_data-nyctaxi-trips-2012-json_corrigido.json

#### Vendors data

- data-vendor_lookup-csv.csv

#### Payments lookup data

- data-payment_lookup-csv.csv

The focus of the project is to do an exploratory
analysis and to answer some questions that can be
verified in Analysis.html file.

## Local Development

To reproduce the analysis you will have to clone this repository.

Create a python 3 environment, preferably with [conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/)
```
conda create -n ENV_NAME python=3.7
```
This projects uses Spark. So, before installing it,
you have to install Java 8. On Linux, it can be done
with
```
sudo apt install openjdk-8-jre-headless
sudo apt install openjdk-8-jdk
```

Install the project requirements
```
pip install -r requirements.txt
```

### Running

This project runs on jupyter notebooks. Therefore, running it is
simply opening the jupyter UI and then the notebook

```
jupyter notebook
```

Alternatively, you can have access to the analysis and conclusions
in the Analysis.html file.

## AWS Cloud

The entire environment is provisioned in AWS Cloud, using a EMR Cluster consuming the
data from a s3 bucket. To use the AWS environment you need first to generate a 
access key in the IAM panel. 

Then, install AWS cli
```
pip install awscli
```

Configure the aws cli following this [documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).

Next, put all the data files in a folder called data and upload it to a s3 bucket, 
running the file data_load_s3.sh specifying
the name of the bucket to create.
```
bash data_load_s3.sh -n MY_UNIQUE_BUCKET_NAME
```
Once it loads, head over to the EC2 panel and create a key-pair file named my-key-pair.pem
and place it on the root folder of the project.

Now its time to build the EMR Cluster and access it via jupyter notebook
```
bash setup.sh
```
If you face timeout issues when trying to ssh to the master node, go to the
security groups section on EC2 console and get the security group ID for the master
node. Then, run the following command
```
aws ec2 authorize-security-group-ingress --group-id YOUR_GROUP_ID --protocol tcp --port 22 --cidr 0.0.0.0/0
```
The process should be completed smoothly and when it is finished, the notebook
with the analysis file should be available at 127.0.0.1:8889.




