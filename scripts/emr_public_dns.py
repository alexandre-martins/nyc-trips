# This script gets the public DNS name of the master node when it becomes available, after
# the cluster started. The DNS name is necessary to SSH into the node.

import boto3
import time


def get_emr_dns():
    emr = boto3.client('emr')

    # Wait for the cluster's public DNS name to become available
    while True:
        try:
            # Get the cluster ID of the EMR instance
            cluster_id = emr.list_clusters(ClusterStates=['STARTING', 'BOOTSTRAPPING', 'RUNNING', 'WAITING'])['Clusters'][0]['Id']
            # Get public DNS name
            public_dns = emr.describe_cluster(ClusterId=cluster_id)['Cluster']['MasterPublicDnsName']
        except KeyError:
            time.sleep(60)
            continue
        break

    # Returns its public DNS name
    print(public_dns)


if __name__ == '__main__':
    get_emr_dns()
