from diagrams import Cluster, Diagram, Edge
from diagrams.generic.compute import Rack
from diagrams.generic.storage import Storage

# Variables
title = "Failover TFE"
outformat = "png"
filename = "diagram"
direction = "TB"


with Diagram(
    name=title,
    direction=direction,
    filename=filename,
    outformat=outformat,
) as diag:
    with Cluster("Primary"):
        tfe1 = Rack("TFE1 Server")
    with Cluster("Secondary"):
        tfe2 = Rack("TFE2 Server")
    with Cluster("Storage Replication"):
        disk1 = Storage("Disk1")
        disk2 = Storage("Disk2")

    tfe1 >> disk1
    tfe2 >> disk2
