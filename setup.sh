aws emr create-cluster --auto-scaling-role EMR_AutoScaling_DefaultRole \
		       --applications Name=Hadoop Name=Hive Name=Spark Name=Livy \
		       --ebs-root-volume-size 10 --ec2-attributes '{"KeyName":"my-key-pair","InstanceProfile":"EMR_EC2_DefaultRole","SubnetId":"subnet-f98356a6"}' \
		       --service-role EMR_DefaultRole --enable-debugging --release-label emr-5.30.0 --log-uri 's3n://aws-logs-666808202490-us-east-1/elasticmapreduce/' \
		       --name 'EMR-Cluster' \
		       --instance-groups '[{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":20,"VolumeType":"gp2"},"VolumesPerInstance":1}],"EbsOptimized":true},"InstanceGroupType":"CORE","InstanceType":"m4.large","Name":"Core - 2"},{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":20,"VolumeType":"gp2"},"VolumesPerInstance":1}],"EbsOptimized":true},"InstanceGroupType":"MASTER","InstanceType":"m4.large","Name":"Master - 1"}]' \
		       --scale-down-behavior TERMINATE_AT_TASK_COMPLETION \
		       --region us-east-1

echo Cluster is loading...

# Get the master node public DNS name when it becomes available
emr_public_dns="$(python scripts/emr_public_dns.py)"

chmod 400 my-key-pair.pem
# Copy the nyc_trips_analysis_emr file to the master node
scp -r -i "my-key-pair.pem" -o 'StrictHostKeyChecking no' nyc_trips_analysis_emr.ipynb hadoop@${emr_public_dns}:~/nyc_trips_analysis_emr.ipynb
# Tunel connection on port 8889
ssh -N -f -L 8889:127.0.0.1:8889 -i my-key-pair.pem -o 'StrictHostKeyChecking no' hadoop@${emr_public_dns}
# Connect to the master node and run setup dependencies script
ssh -i "my-key-pair.pem" -o 'StrictHostKeyChecking no' hadoop@${emr_public_dns} 'bash -s' < scripts/emr.sh
